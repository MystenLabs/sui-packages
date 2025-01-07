module 0xb1e18d5399ab3ddefdfa6f8f57e04dcda9d6baa9e3b052abd43a043173e3ae0f::aa1b2c3 {
    struct AA1B2C3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA1B2C3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA1B2C3>(arg0, 9, b"AA1B2C3", b"Abdullah ", b"This is good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4f5a7ac-3a3c-49af-882a-fc4c74a6bffa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA1B2C3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AA1B2C3>>(v1);
    }

    // decompiled from Move bytecode v6
}

