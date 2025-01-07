module 0xc474ccd0519887658d751b58b842fbcf7c996f53138e0d83403cd16f80fba622::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 6, b"SH", b"Sui Hui", x"537569204875692056756e0a546865204772656174204368696e657365205068696c6f736f706865720a22497420646f65736e2774206d617474657220686f7720796f75206c6f6f6b2c206974206d61747465727320686f7720796f75206665656c2e2e2e20616e6420686f7720796f752068616e646c6520612068756922", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_15_52_24_c890943937.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

