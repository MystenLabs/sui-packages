module 0xcf4c7a51e588a41d9dd3990fec11ee3d6790501bc62e6fb4c0842b8f2ddd1415::bpf {
    struct BPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPF>(arg0, 9, b"BPF", b"Bitpuffef", b"Crypto meme coin ready to connect fun and innovation ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9b12a64-8640-4266-bdfe-2ee7df00f5db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

