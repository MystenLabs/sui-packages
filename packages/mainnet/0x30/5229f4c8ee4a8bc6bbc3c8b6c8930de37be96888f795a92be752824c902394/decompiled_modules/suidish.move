module 0x305229f4c8ee4a8bc6bbc3c8b6c8930de37be96888f795a92be752824c902394::suidish {
    struct SUIDISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDISH>(arg0, 6, b"SUIDISH", b"SUIdish Fish", b"Yummy yum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3967_2d40650347.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

