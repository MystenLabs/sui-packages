module 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt_verifier {
    struct VerificationResult has copy, drop {
        is_valid: bool,
        recipient: address,
        circuit_id: u256,
        action_id: u256,
        expiry: u64,
        is_expired: bool,
        is_revoked: bool,
    }

    public fun assert_sbt_for_action(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: u256, arg2: &0x2::clock::Clock) {
        assert_sbt_valid(arg0, arg2);
        assert!(0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::action_id(arg0) == arg1, 4);
    }

    public fun assert_sbt_for_circuit(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: u256, arg2: &0x2::clock::Clock) {
        assert_sbt_valid(arg0, arg2);
        assert!(0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::circuit_id(arg0) == arg1, 3);
    }

    public fun assert_sbt_for_circuit_and_action(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: u256, arg2: u256, arg3: &0x2::clock::Clock) {
        assert_sbt_valid(arg0, arg3);
        assert!(0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::circuit_id(arg0) == arg1, 3);
        assert!(0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::action_id(arg0) == arg2, 4);
    }

    public fun assert_sbt_valid(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: &0x2::clock::Clock) {
        assert!(!is_sbt_expired(arg0, arg1), 1);
        assert!(!is_sbt_revoked(arg0), 2);
    }

    public fun get_sbt_action_id(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken) : u256 {
        0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::action_id(arg0)
    }

    public fun get_sbt_circuit_id(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken) : u256 {
        0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::circuit_id(arg0)
    }

    public fun get_sbt_recipient(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken) : address {
        0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::recipient(arg0)
    }

    public fun is_sbt_expired(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 > 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::expiry(arg0)
    }

    public fun is_sbt_revoked(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken) : bool {
        0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::revoked(arg0)
    }

    public fun is_sbt_valid(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: &0x2::clock::Clock) : bool {
        let v0 = verify_sbt(arg0, arg1);
        v0.is_valid
    }

    public fun result_action_id(arg0: &VerificationResult) : u256 {
        arg0.action_id
    }

    public fun result_circuit_id(arg0: &VerificationResult) : u256 {
        arg0.circuit_id
    }

    public fun result_expiry(arg0: &VerificationResult) : u64 {
        arg0.expiry
    }

    public fun result_is_expired(arg0: &VerificationResult) : bool {
        arg0.is_expired
    }

    public fun result_is_revoked(arg0: &VerificationResult) : bool {
        arg0.is_revoked
    }

    public fun result_is_valid(arg0: &VerificationResult) : bool {
        arg0.is_valid
    }

    public fun result_recipient(arg0: &VerificationResult) : address {
        arg0.recipient
    }

    public fun verify_sbt(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: &0x2::clock::Clock) : VerificationResult {
        let v0 = 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::expiry(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000 > v0;
        let v2 = 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::revoked(arg0);
        let v3 = !v1 && !v2;
        VerificationResult{
            is_valid   : v3,
            recipient  : 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::recipient(arg0),
            circuit_id : 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::circuit_id(arg0),
            action_id  : 0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::action_id(arg0),
            expiry     : v0,
            is_expired : v1,
            is_revoked : v2,
        }
    }

    public fun verify_sbt_for_action(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: u256, arg2: &0x2::clock::Clock) : bool {
        let v0 = verify_sbt(arg0, arg2);
        v0.is_valid && v0.action_id == arg1
    }

    public fun verify_sbt_for_circuit(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: u256, arg2: &0x2::clock::Clock) : bool {
        let v0 = verify_sbt(arg0, arg2);
        v0.is_valid && v0.circuit_id == arg1
    }

    public fun verify_sbt_for_circuit_and_action(arg0: &0x84414f6ef631516d4f4fa65aaad8f9a34fa3582190428b2583e67ee6a821dd05::sbt::SoulBoundToken, arg1: u256, arg2: u256, arg3: &0x2::clock::Clock) : bool {
        let v0 = verify_sbt(arg0, arg3);
        if (v0.is_valid) {
            if (v0.circuit_id == arg1) {
                v0.action_id == arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

