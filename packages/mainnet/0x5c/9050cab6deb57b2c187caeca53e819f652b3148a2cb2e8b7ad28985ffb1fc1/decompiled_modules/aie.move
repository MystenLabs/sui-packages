module 0x5c9050cab6deb57b2c187caeca53e819f652b3148a2cb2e8b7ad28985ffb1fc1::aie {
    struct AIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIE>(arg0, 9, b"AIE", b"Bruce Ali", b"Ich Ich ich ich yaaaaaaah Ich Ich Ich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f72134af-4eab-4185-971f-4aad70f0fb75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

