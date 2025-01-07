module 0x5ab99592c4c6e8164e2992c80d1fde759a7c1880d3e6ec0e4c4d9848835d8b31::khi {
    struct KHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHI>(arg0, 9, b"KHI", b"Khi", x"4b68e1bb89206ec6b0e1bb9b63", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/831af1c1-7149-4ce5-8a27-e05d0c431605.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

