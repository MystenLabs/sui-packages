module 0xd3bf1d9c4675f1be9f046df4219e13cabca5d545fde08c57c530775db9690d16::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"Egg on Sui", b"This token celebrates the Instagram egg, an unassuming image posted on January 4, 2019, that unexpectedly shattered records with over 55 million likes, becoming an instant internet sensation and a symbol of viral fame.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738310575014.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

