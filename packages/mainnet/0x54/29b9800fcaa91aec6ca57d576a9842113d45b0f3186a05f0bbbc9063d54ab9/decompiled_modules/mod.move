module 0x5429b9800fcaa91aec6ca57d576a9842113d45b0f3186a05f0bbbc9063d54ab9::mod {
    struct MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOD>(arg0, 9, b"MOD", b"MODEL", b"Stake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3ad4a83-152d-45fb-8ece-622976a3ab96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

