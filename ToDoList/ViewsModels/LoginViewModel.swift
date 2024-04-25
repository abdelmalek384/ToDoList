import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isPasswordResetSent = false

    init() {}

    func login() {
        guard validate() else {
            return
        }

        // Try log in
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle authentication error
                self.errorMessage = "Failed to log in: \(error.localizedDescription)"
                return
            }

            // Authentication successful, clear error message
            self.errorMessage = ""
        }
    }

  

    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }

        return true
    }
}
