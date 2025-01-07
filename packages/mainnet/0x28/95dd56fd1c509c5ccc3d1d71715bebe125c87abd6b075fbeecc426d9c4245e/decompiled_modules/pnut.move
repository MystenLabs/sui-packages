module 0x2895dd56fd1c509c5ccc3d1d71715bebe125c87abd6b075fbeecc426d9c4245e::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut the Squirrel", b"If you strike me down, I will become more powerful than you could possibly imagine Obi PNut Kenobi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Z_Gbf_Aa_IAA_CQH_585354a14b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

