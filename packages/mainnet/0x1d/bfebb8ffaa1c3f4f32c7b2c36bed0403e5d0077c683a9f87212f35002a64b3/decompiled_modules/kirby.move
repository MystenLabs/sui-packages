module 0x1dbfebb8ffaa1c3f4f32c7b2c36bed0403e5d0077c683a9f87212f35002a64b3::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"Kirby", b"this one is for the community! dev only hold a 3%!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kirby_65153deaad.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

