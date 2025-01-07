module 0xea97b590fb44e210c3858a424c1c6c6809040e7e189e0ef15bc482e468edfed2::minter_manager {
    struct MINTER_MANAGER has drop {
        dummy_field: bool,
    }

    struct TreasuryCapManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        superAdmin: address,
        treasuryCap: 0x2::coin::TreasuryCap<T0>,
        revokedMinters: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct MinterCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        managerId: 0x2::object::ID,
    }

    public entry fun burn<T0>(arg0: u64, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut MinterCap<T0>, arg3: &mut TreasuryCapManager<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg3.revokedMinters, 0x2::object::uid_to_inner(&arg2.id)), 3);
        assert!(arg2.managerId == 0x2::object::uid_to_inner(&arg3.id), 2);
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
        0x2::coin::burn<T0>(&mut arg3.treasuryCap, 0x2::coin::split<T0>(&mut v0, arg0, arg4));
    }

    public entry fun destroyTreasuryCapManager<T0>(arg0: TreasuryCapManager<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.superAdmin, 1);
        let TreasuryCapManager {
            id             : v0,
            superAdmin     : _,
            treasuryCap    : v2,
            revokedMinters : v3,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table::drop<0x2::object::ID, bool>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MINTER_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINTER_MANAGER>(arg0, 18, b"BBUSD", b"BBUSD", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINTER_MANAGER>>(v1);
        let v2 = 0x2::tx_context::sender(arg1);
        setupTreasuryCapManager<MINTER_MANAGER>(v2, v0, arg1);
    }

    public entry fun issueMinterCap<T0>(arg0: address, arg1: &TreasuryCapManager<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.superAdmin, 1);
        let v0 = MinterCap<T0>{
            id        : 0x2::object::new(arg2),
            managerId : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::transfer::public_transfer<MinterCap<T0>>(v0, arg0);
    }

    public entry fun mint<T0>(arg0: u64, arg1: address, arg2: &mut MinterCap<T0>, arg3: &mut TreasuryCapManager<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg3.revokedMinters, 0x2::object::uid_to_inner(&arg2.id)), 3);
        assert!(arg2.managerId == 0x2::object::uid_to_inner(&arg3.id), 2);
        0x2::coin::mint_and_transfer<T0>(&mut arg3.treasuryCap, arg0, arg1, arg4);
    }

    public entry fun revokeMinterCap<T0>(arg0: &MinterCap<T0>, arg1: &mut TreasuryCapManager<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.superAdmin, 1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.revokedMinters, 0x2::object::uid_to_inner(&arg0.id), true);
    }

    public entry fun setupTreasuryCapManager<T0>(arg0: address, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCapManager<T0>{
            id             : 0x2::object::new(arg2),
            superAdmin     : arg0,
            treasuryCap    : arg1,
            revokedMinters : 0x2::table::new<0x2::object::ID, bool>(arg2),
        };
        0x2::transfer::public_share_object<TreasuryCapManager<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

