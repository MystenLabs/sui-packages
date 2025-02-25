module 0xa64b393ccdc78369b511f5e7ca61a52e03333638f625b5d1a865e9f506ab576e::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 6, b"KFC", b"KFC", b"Crazy Thursday", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KFC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

