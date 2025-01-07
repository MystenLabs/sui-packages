module 0x6719bf3b585ff7e69ac49a37c83b1be39b3d990e6ee4836977510b25d6f7ed19::decry {
    struct DECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRY>(arg0, 9, b"DECRY", b"De cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6102e6f-ebcb-44d5-872c-b86d68f0bdca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

