module 0x3eefeb710c0b7ab863471dee7e943ac19a113a1a4325a098f7e2d3fd3db027cf::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"WALRUS", b"Walrus_Sui", b"Welcome to the next generation of data storage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cnn_5_Kz_C_400x400_681c9f043b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

