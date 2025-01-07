module 0xad2d116d9aa4db57484007f5e20242ff206530b8d763693a276ae36b397c4786::decoin {
    struct TranscriptRequestEvent has copy, drop {
        wrapper_id: u64,
        intended_address: address,
    }

    struct DECOIN has drop {
        dummy_field: bool,
    }

    public entry fun buy_coin(arg0: &mut 0x2::coin::Coin<DECOIN>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::coin::TreasuryCap<DECOIN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg2, 2004);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2), arg4), @0xd73a6dc9ff5222aed93d45049767837030c74cba9835d8796c7acd311c12e0e2);
        0x2::coin::join<DECOIN>(arg0, 0x2::coin::mint<DECOIN>(arg3, arg2 * 10, arg4));
    }

    fun init(arg0: DECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECOIN>(arg0, 9, b"DetaskCoin", b"DetaskCoin", b"Detask Coins", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_coin(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DECOIN>>(0x2::coin::zero<DECOIN>(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun init_for_testing(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"star test init_for_testing");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0x1::string::utf8(b"star test init_for_testing end");
        0x1::debug::print<0x1::string::String>(&v1);
    }

    public entry fun transfer_to_other(arg0: u64, arg1: 0x2::coin::Coin<DECOIN>, arg2: address) {
        let v0 = TranscriptRequestEvent{
            wrapper_id       : arg0,
            intended_address : arg2,
        };
        0x2::event::emit<TranscriptRequestEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DECOIN>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

