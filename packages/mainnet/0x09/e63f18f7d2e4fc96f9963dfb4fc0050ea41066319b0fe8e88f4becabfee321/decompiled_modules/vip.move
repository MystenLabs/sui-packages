module 0x9e63f18f7d2e4fc96f9963dfb4fc0050ea41066319b0fe8e88f4becabfee321::vip {
    struct VIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIP>(arg0, 9, b"VIP", x"48e1baad6b736b6761", b"Ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/974b7243-a4fa-4e56-bf4e-272fb9c0f540.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

