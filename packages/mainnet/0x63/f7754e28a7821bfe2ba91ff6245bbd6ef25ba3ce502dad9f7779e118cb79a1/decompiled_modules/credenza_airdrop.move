module 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_airdrop {
    struct CredenzaAirdropConfig has store, key {
        id: 0x2::object::UID,
        items: 0x2::bag::Bag,
        owner: address,
        per_address_limit: u64,
        dropped_amount_coin: 0x2::table::Table<address, u64>,
        dropped_amount_asset: 0x2::table::Table<address, 0x2::table::Table<u64, u64>>,
    }

    struct CredenzaAirdropConfigCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CredenzaAirdropConfig{
            id                   : 0x2::object::new(arg0),
            items                : 0x2::bag::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            per_address_limit    : 0,
            dropped_amount_coin  : 0x2::table::new<address, u64>(arg0),
            dropped_amount_asset : 0x2::table::new<address, 0x2::table::Table<u64, u64>>(arg0),
        };
        let v1 = CredenzaAirdropConfigCreatedEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CredenzaAirdropConfigCreatedEvent>(v1);
        0x2::transfer::share_object<CredenzaAirdropConfig>(v0);
    }

    public fun request_asset(arg0: &mut CredenzaAirdropConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<u64>(&arg0.items, arg1), 1);
        let v1 = arg2;
        if (0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&arg0.dropped_amount_asset, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.dropped_amount_asset, v0);
            if (0x2::table::contains<u64, u64>(v2, arg1)) {
                v1 = arg2 + 0x2::table::remove<u64, u64>(v2, arg1);
            };
        } else {
            0x2::table::add<address, 0x2::table::Table<u64, u64>>(&mut arg0.dropped_amount_asset, v0, 0x2::table::new<u64, u64>(arg3));
        };
        if (arg0.per_address_limit > 0) {
            assert!(arg0.per_address_limit >= v1, 2);
        };
        0x2::table::add<u64, u64>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg0.dropped_amount_asset, v0), arg1, v1);
        let v3 = 0x2::bag::borrow_mut<u64, 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::TokenizedAsset>(&mut arg0.items, arg1);
        assert!(arg2 <= 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::value(v3), 4);
        0x2::transfer::public_transfer<0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::TokenizedAsset>(0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::split(v3, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun request_coin<T0>(arg0: &mut CredenzaAirdropConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.items, v0), 1);
        let v2 = arg1;
        if (0x2::table::contains<address, u64>(&arg0.dropped_amount_coin, v1)) {
            v2 = arg1 + 0x2::table::remove<address, u64>(&mut arg0.dropped_amount_coin, v1);
        };
        if (arg0.per_address_limit > 0) {
            assert!(arg0.per_address_limit >= v2, 2);
        };
        0x2::table::add<address, u64>(&mut arg0.dropped_amount_coin, v1, v2);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.items, v0);
        assert!(arg1 <= 0x2::coin::value<T0>(v3), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v3, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun set_asset(arg0: &mut CredenzaAirdropConfig, arg1: 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::TokenizedAsset, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::asset_id(&arg1);
        if (0x2::bag::contains<u64>(&arg0.items, v0)) {
            0x2::transfer::public_transfer<0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::TokenizedAsset>(0x2::bag::remove<u64, 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::TokenizedAsset>(&mut arg0.items, v0), 0x2::tx_context::sender(arg2));
        };
        0x2::bag::add<u64, 0x63f7754e28a7821bfe2ba91ff6245bbd6ef25ba3ce502dad9f7779e118cb79a1::credenza_asset_collection::TokenizedAsset>(&mut arg0.items, v0, arg1);
    }

    public fun set_coin<T0, T1>(arg0: &mut CredenzaAirdropConfig, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.items, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.items, v0), 0x2::tx_context::sender(arg2));
        };
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T1>>(&mut arg0.items, v0, arg1);
    }

    public fun set_drop_per_address_limit(arg0: &mut CredenzaAirdropConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.per_address_limit = arg1;
    }

    // decompiled from Move bytecode v6
}

