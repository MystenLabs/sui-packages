module 0xd1e9d38d737c33174b8dd81efc1e0cf270a0c122cf1efa62ecba3550cd98ed26::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G>(arg0, 9, b"G", b"Delphinida", b"Ocean dolphins need to be preserved", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f442b07-ea82-4080-a583-adcd65637790.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G>>(v1);
    }

    // decompiled from Move bytecode v6
}

