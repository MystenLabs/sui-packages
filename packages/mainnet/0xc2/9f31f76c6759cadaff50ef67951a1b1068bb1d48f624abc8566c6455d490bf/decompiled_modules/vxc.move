module 0xc29f31f76c6759cadaff50ef67951a1b1068bb1d48f624abc8566c6455d490bf::vxc {
    struct VXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VXC>(arg0, 9, b"VXC", b"VBFDX", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fd8b9a7-1e55-4688-9769-3b64b2309490.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

