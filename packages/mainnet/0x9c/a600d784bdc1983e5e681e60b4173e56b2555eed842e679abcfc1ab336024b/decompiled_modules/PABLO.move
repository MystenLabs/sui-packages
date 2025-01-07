module 0x9ca600d784bdc1983e5e681e60b4173e56b2555eed842e679abcfc1ab336024b::PABLO {
    struct PABLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PABLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PABLO>(arg0, 9, b"PABLO", b"Pablo DeFi", b"Home to premier DeFi Protocols, $PABLO is a force of true utility and DeFi protocols with the unbridled power of Crypto Pablo memetics!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GEd9RqeWUAAMDqv?format=png&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PABLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PABLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PABLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PABLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

