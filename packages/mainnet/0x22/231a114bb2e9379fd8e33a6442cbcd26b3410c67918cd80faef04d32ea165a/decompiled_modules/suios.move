module 0x22231a114bb2e9379fd8e33a6442cbcd26b3410c67918cd80faef04d32ea165a::suios {
    struct SUIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOS>(arg0, 9, b"SuiOS", b"SuiOS", b"Future of DEX trading on  Sui , Ignited by the fiery spirit of SuiOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suios.xyz/token/suios.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIOS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

