module 0x18a68857bfb86e00035fea9998b263cf078d1da2e1bde2fb8cdafe536a5f37d7::bvxc {
    struct BVXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVXC>(arg0, 9, b"BVXC", b"BD", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12ade4a2-9dc8-4004-b68c-fc0f83239d80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

