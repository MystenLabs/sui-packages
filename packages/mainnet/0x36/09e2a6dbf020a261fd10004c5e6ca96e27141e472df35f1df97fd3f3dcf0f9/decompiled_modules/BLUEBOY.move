module 0x3609e2a6dbf020a261fd10004c5e6ca96e27141e472df35f1df97fd3f3dcf0f9::BLUEBOY {
    struct BLUEBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBOY>(arg0, 9, b"BLUEBOY", b"BLUEBOY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEBOY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEBOY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEBOY>>(0x2::coin::mint<BLUEBOY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

