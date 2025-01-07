module 0xb97179987b691190c5ac910b52f160788d2d09122dbbe46737e9d4184c6cc7c::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"SUN", b"Suncat ", x"2a546f6b656e204e616d653a2a2053554e4341540a0a2a546f6b656e2053796d626f6c3a2a2053554e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ad623a7-c553-44fc-83c9-915801d50b06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

