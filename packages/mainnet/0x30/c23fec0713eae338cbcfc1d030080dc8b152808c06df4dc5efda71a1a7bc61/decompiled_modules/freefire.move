module 0x30c23fec0713eae338cbcfc1d030080dc8b152808c06df4dc5efda71a1a7bc61::freefire {
    struct FREEFIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEFIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEFIRE>(arg0, 9, b"FREEFIRE", b"Wax", b"A meme killer on sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a54c2064-f948-4e30-98c4-4bb999740cdd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEFIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREEFIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

