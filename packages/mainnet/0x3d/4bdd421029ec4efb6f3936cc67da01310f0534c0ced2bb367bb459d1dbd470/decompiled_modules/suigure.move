module 0x3d4bdd421029ec4efb6f3936cc67da01310f0534c0ced2bb367bb459d1dbd470::suigure {
    struct SUIGURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGURE>(arg0, 6, b"SUIgure", b"Shigure", b"Shigure, known for her captivating presence and dynamic personality, leads a formidable gang in the crypto world with the ticker $SUIgure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VS_0zv5_Tt_400x400_713450957e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

