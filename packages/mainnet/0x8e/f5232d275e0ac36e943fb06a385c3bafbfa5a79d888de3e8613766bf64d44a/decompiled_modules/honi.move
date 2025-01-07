module 0x8ef5232d275e0ac36e943fb06a385c3bafbfa5a79d888de3e8613766bf64d44a::honi {
    struct HONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONI>(arg0, 9, b"HONI", b"Hon", b"HONTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af0e7d38-1e6a-4477-ac45-76b01d386ab6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

