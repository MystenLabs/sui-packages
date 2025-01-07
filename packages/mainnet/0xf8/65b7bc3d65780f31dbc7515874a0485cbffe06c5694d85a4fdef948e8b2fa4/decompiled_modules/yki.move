module 0xf865b7bc3d65780f31dbc7515874a0485cbffe06c5694d85a4fdef948e8b2fa4::yki {
    struct YKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YKI>(arg0, 6, b"YKI", b"Takoyaki", b" 'Takoyaki` is a popular Japanese street food made by our cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oqj_F1_Cbp_400x400_701f318b66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

