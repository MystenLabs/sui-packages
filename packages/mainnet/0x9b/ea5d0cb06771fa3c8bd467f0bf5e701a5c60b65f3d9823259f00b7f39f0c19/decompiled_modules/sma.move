module 0x9bea5d0cb06771fa3c8bd467f0bf5e701a5c60b65f3d9823259f00b7f39f0c19::sma {
    struct SMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMA>(arg0, 9, b"SMA", b"vann samba", b"blue with green", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc9c0e9c-29f0-40ff-818d-452aad58536a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

