module 0x82a3c069b06b40ddb757c1086284c6c13b940f83ea8e15bea59a9486b686e335::lewis {
    struct LEWIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEWIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEWIS>(arg0, 6, b"LEWIS", b"NOT A JACK O LANTERN", b"Pumpkin Halloween ghoul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_PPEUK_Xf_400x400_151184d732.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEWIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEWIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

