module 0x61cf51871012962e2c98cac187f7e3812a25dbf4c569f9b2f7979e72d0415b4b::tobi {
    struct TOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBI>(arg0, 6, b"TOBI", b"TOBI SUI MEME", b"Meme Artists own Tobi Community. Meme contest and fan art contest open every week.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xobi_292ebef48e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

