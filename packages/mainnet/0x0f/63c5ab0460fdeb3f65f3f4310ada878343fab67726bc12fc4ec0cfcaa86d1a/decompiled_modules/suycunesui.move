module 0xf63c5ab0460fdeb3f65f3f4310ada878343fab67726bc12fc4ec0cfcaa86d1a::suycunesui {
    struct SUYCUNESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUYCUNESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUYCUNESUI>(arg0, 6, b"SUYCUNESUI", b"SUYCUNE", b"The Legendary Beast of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_013251000_703ae1c000.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUYCUNESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUYCUNESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

