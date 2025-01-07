module 0xc2c1124449ca7d3ae92f130ac9dbbe4fa445f5f40fd5e4d6bc946c0439b290dd::dannthedemon {
    struct DANNTHEDEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANNTHEDEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANNTHEDEMON>(arg0, 6, b"DANNTHEDEMON", b"DANN THE DEMON SUI", b"His day job as a sleep paralysis demon wasn't paying the bills. so now he trades meme coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_I_Sg8_QGG_400x400_c5066b9eca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANNTHEDEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANNTHEDEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

