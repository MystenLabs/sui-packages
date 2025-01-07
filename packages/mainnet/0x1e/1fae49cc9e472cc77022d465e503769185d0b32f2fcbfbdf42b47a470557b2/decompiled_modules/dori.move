module 0x1e1fae49cc9e472cc77022d465e503769185d0b32f2fcbfbdf42b47a470557b2::dori {
    struct DORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORI>(arg0, 6, b"DORI", b"DORY ON SUI", x"504550452753206265737420667269656e64206f6e205355492e204f6e65206f662063727970746f73206d6f7374207369676e69666963616e742063756c747572616c2069636f6e7320616e6420746865206d6173636f74206f662053554920636861696e0a4c697665206f6e20486f702046756e20736f6f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_24_at_04_35_18_438ba4b1_dea0cb56bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

