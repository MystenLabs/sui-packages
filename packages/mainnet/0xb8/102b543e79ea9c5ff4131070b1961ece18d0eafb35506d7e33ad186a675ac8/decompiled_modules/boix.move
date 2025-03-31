module 0xb8102b543e79ea9c5ff4131070b1961ece18d0eafb35506d7e33ad186a675ac8::boix {
    struct BOIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOIX>(arg0, 9, b"BOIX", b"boi", b"lets gooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/569c65c030dc94e1b50fbe5ef26dc0bdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

