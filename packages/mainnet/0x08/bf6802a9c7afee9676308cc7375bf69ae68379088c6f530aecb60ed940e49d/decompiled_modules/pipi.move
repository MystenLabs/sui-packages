module 0x8bf6802a9c7afee9676308cc7375bf69ae68379088c6f530aecb60ed940e49d::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"PIPI", b"pepe scientist", x"57484154205745204e45454420544f20444f204e4f5720495320544f204d414b4520534f4d45204e4f4953452c20414e44204c4554204d4f524520504c4159455253204b4e4f572055532e0a0a414c4c20494e2024504950492e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039978_787f612488.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

