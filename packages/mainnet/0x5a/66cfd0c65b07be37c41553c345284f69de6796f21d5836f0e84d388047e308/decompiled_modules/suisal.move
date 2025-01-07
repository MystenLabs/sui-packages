module 0x5a66cfd0c65b07be37c41553c345284f69de6796f21d5836f0e84d388047e308::suisal {
    struct SUISAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAL>(arg0, 6, b"SUISAL", b"Suisal", x"412053696c6c792053616c6d6f6e204d616b696e6720576176657320696e2074686520537569204f6365616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7ctt_P6_SI_400x400_311ef4cf75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

