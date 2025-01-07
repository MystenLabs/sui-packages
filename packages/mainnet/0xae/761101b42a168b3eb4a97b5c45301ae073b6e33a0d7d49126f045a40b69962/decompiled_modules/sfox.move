module 0xae761101b42a168b3eb4a97b5c45301ae073b6e33a0d7d49126f045a40b69962::sfox {
    struct SFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOX>(arg0, 6, b"SFOX", b"SUI FOX", b"FOX WILL CONTINUE IN NEW JOURNEY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/219_D243_D_0_A31_4_BE_8_A441_46_FEB_44_FEE_2_D_7b372e68c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

