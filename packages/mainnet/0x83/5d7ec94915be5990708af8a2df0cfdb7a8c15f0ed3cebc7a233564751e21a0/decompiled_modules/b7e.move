module 0x835d7ec94915be5990708af8a2df0cfdb7a8c15f0ed3cebc7a233564751e21a0::b7e {
    struct B7E has drop {
        dummy_field: bool,
    }

    fun init(arg0: B7E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B7E>(arg0, 9, b"B7E", b"B7ELEPHANT", x"f09f9098535549206272696e6773206a6f7920616e64206b6e6f776c6564676520746f2065766572796f6e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5eef38b7-d3ea-4e5c-b88b-fabaea3c5b0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B7E>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B7E>>(v1);
    }

    // decompiled from Move bytecode v6
}

