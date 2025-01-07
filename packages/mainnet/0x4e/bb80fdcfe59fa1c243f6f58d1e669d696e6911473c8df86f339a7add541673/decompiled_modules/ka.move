module 0x4ebb80fdcfe59fa1c243f6f58d1e669d696e6911473c8df86f339a7add541673::ka {
    struct KA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KA>(arg0, 9, b"KA", b"Kamina", b"This Is about a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83282fdd-66a1-4a41-bbb8-b174fae6b742.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KA>>(v1);
    }

    // decompiled from Move bytecode v6
}

