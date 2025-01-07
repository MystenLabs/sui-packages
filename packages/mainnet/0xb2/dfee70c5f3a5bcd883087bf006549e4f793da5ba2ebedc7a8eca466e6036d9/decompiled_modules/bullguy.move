module 0xb2dfee70c5f3a5bcd883087bf006549e4f793da5ba2ebedc7a8eca466e6036d9::bullguy {
    struct BULLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLGUY>(arg0, 6, b"BULLGUY", b"BullGuy", b"We aim to become one of the leading memecoins on the Sui network, fostering positive interactions between investors and users. We are committed to adding value to our community and creating an enjoyable experience for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731334144656.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

