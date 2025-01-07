module 0xd5a58904328bf76dca6ab36936ff03a73f9eb6b10b9810c6e4aa4028dd3d16c2::kht {
    struct KHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHT>(arg0, 9, b"KHT", b"HELLO KITT", b"NICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d3e4e27-c6ff-4fbf-8eb4-65374c0024d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

