module 0x4e31fd151edb73493adf382922a3fe5aa0b6558a540eea6837445dcc8198f428::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Leisure SUI Larry", b"Dirty Little Larry is back to pump it hard on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lslsui_5ed8c81a03.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

