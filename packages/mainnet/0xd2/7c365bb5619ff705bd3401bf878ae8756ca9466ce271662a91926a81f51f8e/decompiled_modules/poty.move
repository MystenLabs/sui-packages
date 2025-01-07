module 0xd27c365bb5619ff705bd3401bf878ae8756ca9466ce271662a91926a81f51f8e::poty {
    struct POTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTY>(arg0, 6, b"POTY", b"Sui Poty", b"$POTY is ready", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_39_a6b75c7d69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

