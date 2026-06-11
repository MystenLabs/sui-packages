module 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_per_device: u64,
        device_counts: 0x2::table::Table<vector<u8>, u64>,
        revoked: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct AttestorCap has store, key {
        id: 0x2::object::UID,
    }

    struct CredentialMinted has copy, drop {
        cred_id: 0x2::object::ID,
        holder: address,
        level: u8,
    }

    struct CredentialUpgraded has copy, drop {
        cred_id: 0x2::object::ID,
        new_level: u8,
    }

    struct CredentialRevoked has copy, drop {
        cred_id: 0x2::object::ID,
    }

    public fun renew(arg0: &AttestorCap, arg1: &mut 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::RealHumanCredential, arg2: u64, arg3: &0x2::clock::Clock) {
        0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::renew(arg1, arg2, arg3);
    }

    public fun require_verified(arg0: &Registry, arg1: &0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::RealHumanCredential, arg2: u8, arg3: &0x2::clock::Clock) {
        assert!(!is_revoked(arg0, arg1), 2);
        0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::require_verified(arg1, arg2, arg3);
    }

    public fun upgrade(arg0: &AttestorCap, arg1: &mut 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::RealHumanCredential, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::upgrade(arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
        let v0 = CredentialUpgraded{
            cred_id   : 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::id(arg1),
            new_level : arg2,
        };
        0x2::event::emit<CredentialUpgraded>(v0);
    }

    fun current_device_count(arg0: &Registry, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.device_counts, arg1)) {
            *0x2::table::borrow<vector<u8>, u64>(&arg0.device_counts, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            total_minted   : 0,
            max_per_device : 1,
            device_counts  : 0x2::table::new<vector<u8>, u64>(arg0),
            revoked        : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AttestorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AttestorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_revoked(arg0: &Registry, arg1: &0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::RealHumanCredential) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked, 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::id(arg1))
    }

    public fun max_per_device(arg0: &Registry) : u64 {
        arg0.max_per_device
    }

    public fun mint(arg0: &AttestorCap, arg1: &mut Registry, arg2: address, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(current_device_count(arg1, arg4) < arg1.max_per_device, 1);
        let v0 = 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::new(arg3, arg4, arg5, 0x2::tx_context::sender(arg7), arg6, arg7);
        if (0x2::table::contains<vector<u8>, u64>(&arg1.device_counts, arg4)) {
            let v1 = 0x2::table::borrow_mut<vector<u8>, u64>(&mut arg1.device_counts, arg4);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg1.device_counts, arg4, 1);
        };
        arg1.total_minted = arg1.total_minted + 1;
        let v2 = CredentialMinted{
            cred_id : 0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::id(&v0),
            holder  : arg2,
            level   : arg3,
        };
        0x2::event::emit<CredentialMinted>(v2);
        0x5cd7f8c6c9adb370aa2fdfb9cc3ba93310f70b69f3e8b3596d893e8a51ac3282::credential::transfer_to(v0, arg2);
    }

    public fun revoke(arg0: &AttestorCap, arg1: &mut Registry, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked, arg2)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.revoked, arg2, true);
        };
        let v0 = CredentialRevoked{cred_id: arg2};
        0x2::event::emit<CredentialRevoked>(v0);
    }

    public fun set_max_per_device(arg0: &AttestorCap, arg1: &mut Registry, arg2: u64) {
        arg1.max_per_device = arg2;
    }

    public fun total_minted(arg0: &Registry) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v7
}

