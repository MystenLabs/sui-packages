module 0xba1e727d26d88d7361dd6aee1dceff022141f7a9347753ecc1e26f79d8f3f7d::bwe {
    struct BWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWE>(arg0, 9, b"BWE", b"Bwewe", b"Dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d9d4c5e-8dc1-4e82-9299-632c2558abf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

