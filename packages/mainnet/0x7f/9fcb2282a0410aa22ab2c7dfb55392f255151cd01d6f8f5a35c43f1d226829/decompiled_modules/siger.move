module 0x7f9fcb2282a0410aa22ab2c7dfb55392f255151cd01d6f8f5a35c43f1d226829::siger {
    struct SIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGER>(arg0, 6, b"SIGER", b"SIGER SUI", b"Cat in the guise of tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_11_39_22_3edefca47d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

