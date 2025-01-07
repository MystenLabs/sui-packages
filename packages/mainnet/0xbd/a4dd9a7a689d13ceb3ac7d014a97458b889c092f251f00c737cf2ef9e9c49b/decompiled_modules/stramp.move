module 0xbda4dd9a7a689d13ceb3ac7d014a97458b889c092f251f00c737cf2ef9e9c49b::stramp {
    struct STRAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAMP>(arg0, 6, b"STRAMP", b"Suitramp", b"Sui tramp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004323_d933666477.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

