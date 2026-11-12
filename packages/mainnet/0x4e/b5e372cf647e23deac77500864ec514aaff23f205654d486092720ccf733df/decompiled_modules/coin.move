module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    struct UnlimitedMintCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintManager has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<COIN>,
        user_records: 0x2::table::Table<address, u64>,
    }

    entry fun faucet(arg0: &mut MintManager, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, u64>(&arg0.user_records, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_records, v0);
            assert!(v1 - *v2 >= 86400000, 0);
            *v2 = v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_records, v0, v1);
        };
        0x2::coin::mint_and_transfer<COIN>(&mut arg0.treasury_cap, 2000000000, v0, arg2);
    }

    entry fun faucet_unlimited(arg0: &UnlimitedMintCap, arg1: &mut MintManager, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN>(&mut arg1.treasury_cap, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

