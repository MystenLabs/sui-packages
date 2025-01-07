module 0x5ad4fa17febb8b70409e9c30c410f7102fe305d10c660d7087787b6c7179e14c::llnx {
    struct LLNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLNX>(arg0, 6, b"LLNX", b"LOUD LYNX", b"Fierce and vocal, Loud Lynx prowls the meme wilderness with boldness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_044125914_5f079f3969.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

