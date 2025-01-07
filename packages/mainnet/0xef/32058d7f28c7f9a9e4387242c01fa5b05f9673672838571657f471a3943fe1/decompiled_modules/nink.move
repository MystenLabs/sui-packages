module 0xef32058d7f28c7f9a9e4387242c01fa5b05f9673672838571657f471a3943fe1::nink {
    struct NINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINK>(arg0, 6, b"NINK", b"NEIROLINK", b"Elon Musk activated the $NEIROLINK on his Shiba Inu, Satoshi. Instantly, the dog's brainwaves translated into data showing the next big crypto trends. Satoshi barked once for buy, twice for sell. The internet went wild with \"Shiba Predictions,\" turning $NEIROLINK into the ultimate meme coin sensation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_17_53_43_3f1e281d6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

