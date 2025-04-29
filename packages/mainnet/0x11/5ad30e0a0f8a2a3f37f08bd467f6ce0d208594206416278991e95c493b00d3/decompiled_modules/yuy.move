module 0x115ad30e0a0f8a2a3f37f08bd467f6ce0d208594206416278991e95c493b00d3::yuy {
    struct YUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUY>(arg0, 9, b"YUY", b"yuy", b"yuyyuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

