module 0x75079b307c3306f4952c9227f6268f201b12cfb39799b08f24bd287856b13255::zeds {
    struct ZEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEDS>(arg0, 6, b"ZEDs", b"Zesdan", x"225a657364616e222074726f6e672070686f6e672063c3a163682074c6b0c6a16e67206c61692c2076e1bb9b6920c3a16e682073c3a16e672078616e682076c3a0206ee1bb816e20637962657270756e6b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/771479b6-63cd-4163-bb22-cd6379998acb.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

