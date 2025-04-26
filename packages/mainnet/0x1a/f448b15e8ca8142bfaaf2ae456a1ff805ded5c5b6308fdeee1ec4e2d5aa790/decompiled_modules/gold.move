module 0x1af448b15e8ca8142bfaaf2ae456a1ff805ded5c5b6308fdeee1ec4e2d5aa790::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 9, b"GOLD", b"Pirate Gold", b"JoHoHo and a Bottle of Rum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://banner2.cleanpng.com/20180518/rjl/avra2knr1.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

