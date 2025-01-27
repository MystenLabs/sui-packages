module 0x82270cfba38de383c92dfea8a8b7b324aafdf7f2945575211a92310d2dd8b8f8::BEEF {
    struct BEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEF>(arg0, 9, b"BEEF", b"BEEF", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEEF>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEEF>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BEEF>>(0x2::coin::mint<BEEF>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

