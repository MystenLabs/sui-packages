module 0x5e15e208d38a89a0226586c7ff9aa2fb75ec29212be62e6fd3c9c4308f1afb7d::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SUPA_SUI", b"SUPA One of the bullish #SUI Meme Token in Pacific Sui. $SUPA Soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_91699a2b7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

