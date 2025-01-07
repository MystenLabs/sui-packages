module 0xda70cb5486a470d00c12ed070d013f822e03d3495a0b68911edb1999d0ee9c69::aie {
    struct AIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIE>(arg0, 9, b"AIE", b"Bruce Ali", b"Ich Ich ich ich yaaaaaaah Ich Ich Ich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30d9b6ea-8e3c-4334-8933-78f5c25484fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

