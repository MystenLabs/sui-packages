module 0x4daa45cf8fb1a77216d3d4a0dc8d64f80ec25063198c5a8fdc15de6a3e3a6ea9::vip {
    struct VIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIP>(arg0, 9, b"VIP", b"Vitalii", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9122b17-e8ac-4f0f-99ef-d0a324774ca0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

