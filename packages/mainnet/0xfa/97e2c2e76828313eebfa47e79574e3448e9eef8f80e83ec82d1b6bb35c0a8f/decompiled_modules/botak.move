module 0xfa97e2c2e76828313eebfa47e79574e3448e9eef8f80e83ec82d1b6bb35c0a8f::botak {
    struct BOTAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTAK>(arg0, 9, b"BOTAK", b"Botaks", b"Botak gundul plontos tak ada rambut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb36cd47-c3d5-4986-94b2-68709a007e9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

