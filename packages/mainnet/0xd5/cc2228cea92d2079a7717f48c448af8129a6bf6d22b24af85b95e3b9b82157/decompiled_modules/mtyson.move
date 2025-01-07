module 0xd5cc2228cea92d2079a7717f48c448af8129a6bf6d22b24af85b95e3b9b82157::mtyson {
    struct MTYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTYSON>(arg0, 6, b"MTYSON", b"Mike Tyson Win", b"Mike Tyson Win (MTYSON) is a boxing-inspired meme coin with a bold design of a strong boxer. Built on the Sui blockchain, MTYSON offers fast transactions,  blending the excitement of boxing with the fun of the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731715975834.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTYSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTYSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

