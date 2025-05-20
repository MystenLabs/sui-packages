module 0xcd08bd1b54291b9844de9f00b846e6893efaac245257cb6e644ff8fea09bbd4f::suiark {
    struct SUIARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARK>(arg0, 6, b"SUIARK", b"Zoroark On Sui", x"5a6f726f61726b204f6e20537569206275696c64732053554941524b3a2046616e672026204675727920506f6bc3a96d6f6e2067616d65206f6e205375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxlhjrape5mhygglgyswsketljaz4egubeeiyek4zy5b4jkfdsju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

