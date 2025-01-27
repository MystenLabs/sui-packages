module 0x62f4771dc4aa4b9c623765a2b7fc1ceacf038443a6db843be53c73b471c4fea1::lds {
    struct LDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDS>(arg0, 6, b"LDS", b"LemonDrop on sui", x"4c65742773206578706c6f726520696e746572657374696e67207468696e677320746f676574686572206174204c656d6f6e44726f70210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_27_22_56_10_1fbe94a837.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

