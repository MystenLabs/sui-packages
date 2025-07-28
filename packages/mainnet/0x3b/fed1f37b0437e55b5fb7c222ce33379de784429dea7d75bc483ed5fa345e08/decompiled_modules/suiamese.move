module 0x3bfed1f37b0437e55b5fb7c222ce33379de784429dea7d75bc483ed5fa345e08::suiamese {
    struct SUIAMESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMESE>(arg0, 6, b"SUIAMESE", b"CAT ON SUI", b"Let`s run it back .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifiwwudolnuqhja7wedfq36y5olwe5trod64fxzd2lzaxopxe5zbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAMESE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

