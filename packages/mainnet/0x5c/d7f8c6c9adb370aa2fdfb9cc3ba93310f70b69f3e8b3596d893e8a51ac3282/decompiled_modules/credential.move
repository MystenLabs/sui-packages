module 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential {
    struct RealHumanCredential has key {
        id: 0x2::object::UID,
        level: u8,
        device_commitment: vector<u8>,
        issued_at_ms: u64,
        expires_at_ms: u64,
        attestor: address,
    }

    public fun id(arg0: &RealHumanCredential) : 0x2::object::ID {
        0x2::object::id<RealHumanCredential>(arg0)
    }

    public(friend) fun new(arg0: u8, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : RealHumanCredential {
        assert!(arg0 <= 3, 3);
        RealHumanCredential{
            id                : 0x2::object::new(arg5),
            level             : arg0,
            device_commitment : arg1,
            issued_at_ms      : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms     : arg2,
            attestor          : arg3,
        }
    }

    public fun attestor(arg0: &RealHumanCredential) : address {
        arg0.attestor
    }

    public fun device_commitment(arg0: &RealHumanCredential) : vector<u8> {
        arg0.device_commitment
    }

    public fun expires_at_ms(arg0: &RealHumanCredential) : u64 {
        arg0.expires_at_ms
    }

    public fun holds_at_least(arg0: &RealHumanCredential, arg1: u8, arg2: &0x2::clock::Clock) : bool {
        arg0.level >= arg1 && is_valid(arg0, arg2)
    }

    public fun is_valid(arg0: &RealHumanCredential, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at_ms == 0 || 0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms
    }

    public fun issued_at_ms(arg0: &RealHumanCredential) : u64 {
        arg0.issued_at_ms
    }

    public fun level(arg0: &RealHumanCredential) : u8 {
        arg0.level
    }

    public fun level_device_human() : u8 {
        0
    }

    public fun level_phone() : u8 {
        1
    }

    public fun level_real_action() : u8 {
        2
    }

    public fun level_unique_person() : u8 {
        3
    }

    public(friend) fun renew(arg0: &mut RealHumanCredential, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.issued_at_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.expires_at_ms = arg1;
    }

    public fun require_verified(arg0: &RealHumanCredential, arg1: u8, arg2: &0x2::clock::Clock) {
        assert!(is_valid(arg0, arg2), 1);
        assert!(arg0.level >= arg1, 2);
    }

    public(friend) fun transfer_to(arg0: RealHumanCredential, arg1: address) {
        0x2::transfer::transfer<RealHumanCredential>(arg0, arg1);
    }

    public(friend) fun upgrade(arg0: &mut RealHumanCredential, arg1: u8, arg2: u64, arg3: address) {
        assert!(arg1 <= 3, 3);
        assert!(arg1 >= arg0.level, 4);
        arg0.level = arg1;
        arg0.expires_at_ms = arg2;
        arg0.attestor = arg3;
    }

    // decompiled from Move bytecode v7
}

