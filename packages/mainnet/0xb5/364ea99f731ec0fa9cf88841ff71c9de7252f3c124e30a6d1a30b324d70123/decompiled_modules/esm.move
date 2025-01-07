module 0xb5364ea99f731ec0fa9cf88841ff71c9de7252f3c124e30a6d1a30b324d70123::esm {
    struct ESM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESM>(arg0, 9, b"ESM", b"ELYSIUM", b"Token Juggernaut Wars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/918221de-10a0-4da1-a05f-8d87461e32b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESM>>(v1);
    }

    // decompiled from Move bytecode v6
}

