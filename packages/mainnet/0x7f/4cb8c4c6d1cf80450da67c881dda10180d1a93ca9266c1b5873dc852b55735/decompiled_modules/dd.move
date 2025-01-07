module 0x7f4cb8c4c6d1cf80450da67c881dda10180d1a93ca9266c1b5873dc852b55735::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 6, b"DD", b"Degen Downtrend", b"Degen ! Degen !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732021462436.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

