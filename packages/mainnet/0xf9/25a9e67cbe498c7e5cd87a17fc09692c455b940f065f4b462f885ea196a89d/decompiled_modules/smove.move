module 0xf925a9e67cbe498c7e5cd87a17fc09692c455b940f065f4b462f885ea196a89d::smove {
    struct SMOVE has drop {
        dummy_field: bool,
    }

    struct SMOVESWAP has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SMOVE>,
        store: vector<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
    }

    public fun total_supply(arg0: &SMOVESWAP) : u64 {
        0x2::coin::total_supply<SMOVE>(&arg0.cap)
    }

    public fun get_decimals() : u8 {
        0
    }

    fun init(arg0: SMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOVE>(arg0, 0, b"sMOVECOIN", b"sMOVE", b"sMOVE Coin for $MOVE in Movescription", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://4g7mzcwybmcqsnwiygg4eotqtqkays7y6qyyuycm7tetewing4da.arweave.net/4b7MitgLBQk2yMGNwjpwnBQMS_j0MYpgTPzJMlkNNwY")), arg1);
        let v2 = SMOVESWAP{
            id    : 0x2::object::new(arg1),
            cap   : v0,
            store : 0x1::vector::empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOVE>>(v1);
        0x2::transfer::share_object<SMOVESWAP>(v2);
    }

    public fun ms_to_smove_coin(arg0: &mut SMOVESWAP, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SMOVE> {
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::check_tick(&arg1, b"MOVE"), 2);
        if (0x1::vector::is_empty<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.store)) {
            0x1::vector::push_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.store, arg1);
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.store, 0), arg1);
        };
        0x2::coin::mint<SMOVE>(&mut arg0.cap, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1), arg2)
    }

    public entry fun ms_to_smove_coin_swap(arg0: &mut SMOVESWAP, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ms_to_smove_coin(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SMOVE>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun smove_coin_to_ms(arg0: &mut SMOVESWAP, arg1: 0x2::coin::Coin<SMOVE>, arg2: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = 0x2::coin::burn<SMOVE>(&mut arg0.cap, arg1);
        assert!(v0 > 0, 1);
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::vector::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.store, 0)) == v0) {
            0x1::vector::pop_back<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.store)
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(0x1::vector::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.store, 0), v0, arg2)
        }
    }

    public entry fun smove_coin_to_ms_swap(arg0: &mut SMOVESWAP, arg1: 0x2::coin::Coin<SMOVE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = smove_coin_to_ms(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun total_store(arg0: &SMOVESWAP) : u64 {
        if (0x1::vector::length<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.store) > 0) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::vector::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.store, 0))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

