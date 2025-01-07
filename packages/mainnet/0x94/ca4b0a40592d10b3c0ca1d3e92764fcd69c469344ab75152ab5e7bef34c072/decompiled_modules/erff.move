module 0x94ca4b0a40592d10b3c0ca1d3e92764fcd69c469344ab75152ab5e7bef34c072::erff {
    struct ERFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERFF>(arg0, 6, b"ERFF", b"ERF", b"ERFEF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_20_191258_999c206c53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

