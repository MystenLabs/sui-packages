module 0x26d8c4726c16bf9fbe13700c66f61d84ac2a9740d1bef7ef34f17b871747cbb4::kekeflo {
    struct KEKEFLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKEFLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKEFLO>(arg0, 6, b"Kekeflo", b"Kekeflanel", x"44696262650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048968_2d8ee0b788.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKEFLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKEFLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

