module 0xed3517dff069af9a43eb95009ac7509049e9ffc5955e698bba89d528f36a0b57::zzc {
    struct ZZC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZC>(arg0, 9, b"ZZC", b"Zizics", b"Undisputable nature of art", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d14c88ba-1cfb-4c64-bb0a-c067cba42f65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZC>>(v1);
    }

    // decompiled from Move bytecode v6
}

