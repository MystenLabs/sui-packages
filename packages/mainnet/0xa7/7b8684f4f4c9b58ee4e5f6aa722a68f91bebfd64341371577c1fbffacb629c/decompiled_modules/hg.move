module 0xa77b8684f4f4c9b58ee4e5f6aa722a68f91bebfd64341371577c1fbffacb629c::hg {
    struct HG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HG>(arg0, 9, b"HG", b"Hugo", b"Best of the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fda6f080-89c8-473b-ac66-3e76d9831f7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HG>>(v1);
    }

    // decompiled from Move bytecode v6
}

