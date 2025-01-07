module 0xdffa1def91d6904f4fe656a94e1ce07f0e4dc4822e58c9e70f21e181e8ae50a8::suicapy {
    struct SUICAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAPY>(arg0, 6, b"SUICAPY", b"SUI CAPY", b"THE FIRST OG NFT MEME ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_10_44_05_30930b12f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

