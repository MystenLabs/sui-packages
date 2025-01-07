module 0x528102fa3435790e0ae41114a4141f67a877ce53e02caede96544cb768fad5c0::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 6, b"SuiDoge", b"DOGE", b"The first dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240925_192227_542_c2277f6823.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

