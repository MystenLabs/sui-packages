module 0x611fc4704096f05b61bfd8e9337578d909adb6f7ae742355cedc31c7f566df70::dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DAI>(arg0, 6, b"DAI", b"DOGGIEAI by SuiAI", b"Welcome to the world of Doggie Ai, where we believe in the power of community, the wit of memes, and the potential of AI. Our token is crafted for those who love the thrill of the market with the joy of dog companionship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ffdssss_0c67977dca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

