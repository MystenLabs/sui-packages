module 0x3427a417a268144535d176b80a784907f43f63bce0db720f40f409322c98f39c::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARC>(arg0, 9, b"ARC", b"CART", b"leading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/455a1827-5d70-4eef-8398-fc3a13a2ea7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

