module 0x6cc420510bd3ff84778c25f5a27753eb3ce7cfcefabd1ba16d5853a81db1149d::trust {
    struct Trust has key {
        id: 0x2::object::UID,
    }

    struct SettlorCap has key {
        id: 0x2::object::UID,
        trust_id: 0x2::object::ID,
    }

    struct TrusteeCap has key {
        id: 0x2::object::UID,
        trust_id: 0x2::object::ID,
    }

    struct Key has copy, drop, store {
        name: 0x1::string::String,
    }

    fun is_settlor_cap_correct(arg0: &Trust, arg1: &SettlorCap) {
        assert!(0x2::object::id<Trust>(arg0) == arg1.trust_id, 0);
    }

    fun is_trustee_cap_correct(arg0: &Trust, arg1: &TrusteeCap) {
        assert!(0x2::object::id<Trust>(arg0) == arg1.trust_id, 0);
    }

    // decompiled from Move bytecode v6
}

