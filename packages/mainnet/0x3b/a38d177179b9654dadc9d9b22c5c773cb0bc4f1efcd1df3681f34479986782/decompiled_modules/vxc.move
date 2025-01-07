module 0x3ba38d177179b9654dadc9d9b22c5c773cb0bc4f1efcd1df3681f34479986782::vxc {
    struct VXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VXC>(arg0, 9, b"VXC", b"VBFDX", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1d340b7-f11d-4878-b60e-d7bd1468d6bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

