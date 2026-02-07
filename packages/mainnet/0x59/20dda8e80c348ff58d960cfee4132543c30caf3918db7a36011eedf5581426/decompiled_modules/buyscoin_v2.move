module 0x5920dda8e80c348ff58d960cfee4132543c30caf3918db7a36011eedf5581426::buyscoin_v2 {
    struct BUYS has drop {
        dummy_field: bool,
    }

    struct BUYSCOIN_V2 has drop {
        dummy_field: bool,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        creator: address,
        fee_flat: u64,
        paused: bool,
    }

    fun init(arg0: BUYSCOIN_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<BUYSCOIN_V2>(arg0, 9, 0x1::string::utf8(b"BUYS"), 0x1::string::utf8(b"BUYS Coin"), 0x1::string::utf8(b"BUYS v2 on Sui"), 0x1::string::utf8(b""), arg1);
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<BUYSCOIN_V2>>(0x2::coin::mint<BUYSCOIN_V2>(&mut v3, 1000000000000000000, arg1), v0);
        let v4 = FeeConfig{
            id       : 0x2::object::new(arg1),
            creator  : v0,
            fee_flat : 1000000,
            paused   : false,
        };
        0x2::transfer::share_object<FeeConfig>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYSCOIN_V2>>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BUYSCOIN_V2>>(0x2::coin_registry::finalize<BUYSCOIN_V2>(v1, arg1), v0);
    }

    public fun set_fee_flat(arg0: &mut FeeConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        arg0.fee_flat = arg1;
    }

    public fun set_paused(arg0: &mut FeeConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        arg0.paused = arg1;
    }

    public fun transfer_with_fee(arg0: &FeeConfig, arg1: 0x2::coin::Coin<BUYS>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = arg0.fee_flat;
        assert!(0x2::coin::value<BUYS>(&arg1) >= arg2 + v0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUYS>>(0x2::coin::split<BUYS>(&mut arg1, v0, arg4), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUYS>>(0x2::coin::split<BUYS>(&mut arg1, arg2, arg4), arg3);
        if (0x2::coin::value<BUYS>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BUYS>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<BUYS>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}

