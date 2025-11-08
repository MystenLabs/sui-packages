module 0x56feeee73e65179765d5ccec39613f258a71731574764573fa95874afc3351e6::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDT>(arg0, 6, 0x1::string::utf8(b"USDT"), 0x1::string::utf8(b"USDT"), 0x1::string::utf8(b"USD Tether on Sui"), 0x1::string::utf8(b"https://icon.suntool.cc/file/tether.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0x0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<USDT>>(0x2::coin_registry::finalize<USDT>(v0, arg1), @0x0);
    }

    // decompiled from Move bytecode v6
}

