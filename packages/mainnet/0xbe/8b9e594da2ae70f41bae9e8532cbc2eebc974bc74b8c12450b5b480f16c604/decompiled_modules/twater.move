module 0xbe8b9e594da2ae70f41bae9e8532cbc2eebc974bc74b8c12450b5b480f16c604::twater {
    struct TWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWATER>(arg0, 6, b"TWATER", b"trump loves water", b"trump loves eating and drinking water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_03_01_48_39_bbe1c2f457.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

