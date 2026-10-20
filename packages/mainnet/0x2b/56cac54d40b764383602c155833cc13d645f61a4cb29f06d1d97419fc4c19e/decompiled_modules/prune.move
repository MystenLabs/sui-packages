module 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::prune {
    struct PRUNE has drop {
        dummy_field: bool,
    }

    struct BootstrapCap has key {
        id: 0x2::object::UID,
    }

    public fun bootstrap(arg0: BootstrapCap, arg1: &mut 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<PRUNE>, arg2: &mut 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::Governance, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg5: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Arena) {
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::assert_version<PRUNE>(arg1);
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::assert_version(arg2);
        assert!(0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::dist_id(arg2) == 0x2::object::id<0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<PRUNE>>(arg1), 0);
        let BootstrapCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg3) + 1;
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::bootstrap<PRUNE>(arg1, v1, 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard>(arg3), 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai::Arena>(arg5));
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::bootstrap(arg2, v1, 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard>(arg3), 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config>(arg4));
    }

    public fun migrate(arg0: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::AdminCap, arg1: &mut 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<PRUNE>, arg2: &mut 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::OperatorLock<PRUNE>, arg3: &mut 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::Governance) {
        assert!(0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::dist_id(arg3) == 0x2::object::id<0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<PRUNE>>(arg1), 0);
        assert!(0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::lock_id(arg3) == 0x2::object::id<0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::OperatorLock<PRUNE>>(arg2), 0);
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::migrate<PRUNE>(arg1);
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::migrate<PRUNE>(arg2);
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::migrate(arg3);
    }

    fun init(arg0: PRUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PRUNE>(arg0, 9, 0x1::string::utf8(b"PRUNE"), 0x1::string::utf8(b"Prune"), 0x1::string::utf8(b"Votes on the rules of Hash Bonsai. Given out each epoch for Standing scores and for every Bonsai held."), 0x1::string::utf8(b"https://hashbonsai-assets.wal.app/prune-icon.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::mint_balance<PRUNE>(&mut v2, 100000000000000000);
        0x2::coin_registry::make_supply_fixed_init<PRUNE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PRUNE>(v3, arg1);
        let v5 = 0x2::balance::split<PRUNE>(&mut v4, 55000000000000000);
        0x2::balance::join<PRUNE>(&mut v5, 0x2::balance::split<PRUNE>(&mut v4, 30000000000000000));
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance::create(0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::create<PRUNE>(v5, 55000000000000000, 30000000000000000, arg1), 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::create<PRUNE>(v4, 0x2::tx_context::epoch_timestamp_ms(arg1) + 31536000000, @0x3aad91f466934ed60376f1e79ed6ec523767f9465b54a19407ea054729b89442, arg1), arg1);
        let v6 = BootstrapCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BootstrapCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun operator_share() : u64 {
        15000000000000000
    }

    public fun total_supply() : u64 {
        100000000000000000
    }

    // decompiled from Move bytecode v7
}

