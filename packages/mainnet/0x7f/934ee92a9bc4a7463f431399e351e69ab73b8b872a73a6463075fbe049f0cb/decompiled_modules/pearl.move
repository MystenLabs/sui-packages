module 0x7f934ee92a9bc4a7463f431399e351e69ab73b8b872a73a6463075fbe049f0cb::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"PEARL", b"SUI PEARL", b"Sui Pearl is more than just a cryptocurrency; it's a vibrant community-driven project that aims to bring smiles, laughter, and reward to it holders Sui pearl symbolizes growth, positivity, and a mindset to build  towards a brighter future in the crypto space. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_23_05_37_25_4a0ed09870.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

