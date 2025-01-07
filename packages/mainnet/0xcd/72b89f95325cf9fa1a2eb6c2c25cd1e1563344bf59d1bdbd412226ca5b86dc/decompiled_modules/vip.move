module 0xcd72b89f95325cf9fa1a2eb6c2c25cd1e1563344bf59d1bdbd412226ca5b86dc::vip {
    struct VIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIP>(arg0, 9, b"VIP", x"48e1baad6b736b6761", b"Ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bec4926-6e9f-460d-bed6-66b6a6d52722.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

