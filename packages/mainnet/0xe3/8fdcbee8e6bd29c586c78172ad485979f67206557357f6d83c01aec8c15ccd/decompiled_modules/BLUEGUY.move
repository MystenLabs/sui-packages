module 0xe38fdcbee8e6bd29c586c78172ad485979f67206557357f6d83c01aec8c15ccd::BLUEGUY {
    struct BLUEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEGUY>(arg0, 9, b"BLUEGUY", b"BLUEGUY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEGUY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEGUY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEGUY>>(0x2::coin::mint<BLUEGUY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

