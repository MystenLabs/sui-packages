module 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::usda {
    struct USDA has drop {
        dummy_field: bool,
    }

    struct TreasuryCapManager has key {
        id: 0x2::object::UID,
        version: u8,
        treasury: 0x2::coin::TreasuryCap<USDA>,
        revoked_minters: vector<0x2::object::ID>,
        revoked_burners: vector<0x2::object::ID>,
    }

    public fun burn(arg0: 0x2::coin::Coin<USDA>, arg1: &mut TreasuryCapManager, arg2: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::BurnerCap, arg3: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig) : u64 {
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::assert_not_paused(arg3);
        check_version(arg1.version);
        let v0 = 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::get_burner_cap_id(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_burners, &v0), 2);
        0x2::coin::burn<USDA>(&mut arg1.treasury, arg0)
    }

    public fun mint(arg0: u64, arg1: &mut TreasuryCapManager, arg2: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::MinterCap, arg3: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDA> {
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::assert_not_paused(arg3);
        check_version(arg1.version);
        let v0 = 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::get_minter_cap_id(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_minters, &v0), 2);
        0x2::coin::mint<USDA>(&mut arg1.treasury, arg0, arg4)
    }

    public fun is_paused(arg0: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig) : bool {
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::is_paused(arg0)
    }

    public entry fun set_pause(arg0: bool, arg1: &mut 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::assert_pause_admin(arg1, 0x2::tx_context::sender(arg2));
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::set_pause(arg1, arg0);
    }

    fun check_version(arg0: u8) {
        assert!(arg0 == 0, 1);
    }

    fun init(arg0: USDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<USDA>(arg0, 6, b"USDa", b"USDa", b"USDa by Avalon Labs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaPc3p5AFRNgA4jPhrSmqnvfVERLX7LYBBvr3pZrq714g")), true, arg1);
        let v3 = TreasuryCapManager{
            id              : 0x2::object::new(arg1),
            version         : 0,
            treasury        : v0,
            revoked_minters : 0x1::vector::empty<0x2::object::ID>(),
            revoked_burners : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TreasuryCapManager>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDA>>(v2);
    }

    entry fun migrate(arg0: &mut TreasuryCapManager, arg1: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AdminCap) {
        assert!(arg0.version < 0, 0);
        arg0.version = 0;
    }

    public entry fun revoke_burner_cap(arg0: 0x2::object::ID, arg1: &mut TreasuryCapManager, arg2: &mut 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig, arg3: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_burners, &arg0), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_burners, arg0);
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::burner_cap_revoked(arg0, arg2);
    }

    public entry fun revoke_minter_cap(arg0: 0x2::object::ID, arg1: &mut TreasuryCapManager, arg2: &mut 0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AccessConfig, arg3: &0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_minters, &arg0), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_minters, arg0);
        0xa8b2db45ac95230a29b7b495dbf571d96749f3380769b8464488773d05a0c179::access_control::minter_cap_revoked(arg0, arg2);
    }

    public fun revoked_burners(arg0: &TreasuryCapManager) : vector<0x2::object::ID> {
        arg0.revoked_burners
    }

    public fun revoked_minters(arg0: &TreasuryCapManager) : vector<0x2::object::ID> {
        arg0.revoked_minters
    }

    // decompiled from Move bytecode v6
}

