module 0x64a21a6c825382261b0dede297d049c7a8d3f38fadc18814e4d2ed0b50bd88d8::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLY>(arg0, 6, b"SILLY", b"SILLY CATAI", b"SILLY CAT live now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxb4rfbugn5cmgphyvg6gwxi5ujqrpg3ypxdquc5dgxofnmaga4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SILLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

