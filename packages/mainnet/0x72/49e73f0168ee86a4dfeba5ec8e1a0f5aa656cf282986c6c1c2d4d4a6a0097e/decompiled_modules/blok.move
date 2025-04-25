module 0x7249e73f0168ee86a4dfeba5ec8e1a0f5aa656cf282986c6c1c2d4d4a6a0097e::blok {
    struct BLOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOK>(arg0, 9, b"BLOK", b"Captain Blok", b"Captain Blok is a friendly world-builder, made entirely of colorful blocks. With his bright yellow cap and shy smile, he travels through lands of tiny bricks to help build dreams. His right arm has been replaced with a handy hook tool, perfect for climbing blocky mountains or rescuing friends in need. Wearing his red and black uniform and sturdy boots, Captain Blok is always ready for new adventures in a geometric universe where anything is possible!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7822b5e5bab53e3fd96ed36def7456a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

