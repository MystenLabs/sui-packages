module 0x57ccbd7bdbe77db69c12480669631d5762e8e6b395dbd0660088db0e7358fdc4::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"SUN", b"Suncat ", x"2a546f6b656e204e616d653a2a2053554e4341540a0a2a546f6b656e2053796d626f6c3a2a2053554e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce26a3ad-ead0-49cc-9e86-1f197304fe3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

