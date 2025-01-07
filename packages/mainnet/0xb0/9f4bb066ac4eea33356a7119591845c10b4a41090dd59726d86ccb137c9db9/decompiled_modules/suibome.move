module 0xb09f4bb066ac4eea33356a7119591845c10b4a41090dd59726d86ccb137c9db9::suibome {
    struct SUIBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOME>(arg0, 6, b"SUIBOME", b"SUIBOME", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ISF8TOC.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBOME>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

