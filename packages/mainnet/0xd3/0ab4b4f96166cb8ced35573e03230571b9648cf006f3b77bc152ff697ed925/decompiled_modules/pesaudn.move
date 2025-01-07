module 0xd30ab4b4f96166cb8ced35573e03230571b9648cf006f3b77bc152ff697ed925::pesaudn {
    struct PESAUDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESAUDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESAUDN>(arg0, 9, b"PESAUDN", b"Pesau", b"Token vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46e41bb4-289d-4b30-9277-201891825b1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESAUDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PESAUDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

