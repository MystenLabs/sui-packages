module 0xb84601d2fb6db60a4e7b864dcb5111f5b714ceec76367d667f1738d3074e9008::suifu {
    struct SUIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFU>(arg0, 6, b"SUIFU", b"Sui Fu", b"Sui Fu emerges as a unique project, bringing to life the legendary story of a kung fu turtle. This isn't just any turtle; Sui Fu embodies wisdom, strength, and the spirit of perseverance, all while making the world of cryptocurrencies more engaging and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Sui_JPG_509f740b6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

