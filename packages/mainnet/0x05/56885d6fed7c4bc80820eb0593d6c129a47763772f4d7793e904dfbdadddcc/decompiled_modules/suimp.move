module 0x556885d6fed7c4bc80820eb0593d6c129a47763772f4d7793e904dfbdadddcc::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"SUIMP", b"SUI Shrimp", b"Suimp, the tiniest shrimp on the Sui blockchain ocean, is here to make waves! With a mission to turn small fish into whales, Suimp brings Web3 knowledge, memes, and fun to the crypto space. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735982750902.50")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

