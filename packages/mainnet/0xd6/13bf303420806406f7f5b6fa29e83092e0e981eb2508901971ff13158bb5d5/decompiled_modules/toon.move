module 0xd613bf303420806406f7f5b6fa29e83092e0e981eb2508901971ff13158bb5d5::toon {
    struct TOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOON>(arg0, 6, b"TOON", b"TOON on SUI", x"54686520544f4f4e204361742053656e742046726f6d20546865205061737420546f205361766520596f75722046757475726520616e64205468652042756c6c2052756e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tn_Xh4r77_400x400_e5805dd2a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

