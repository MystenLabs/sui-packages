module 0xfa158455caccdfa1f0c75ad5abc4ee918dd730fcd68ea208a91269c4b2cb8f9::susek {
    struct SUSEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSEK>(arg0, 6, b"SUSEK", b"SuiSeki", b"Sui Seki Sui Network Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_11_00_12_d6ac887bc8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

