module 0x89b0285e067559f2c990035756c6eaa7cc6b856bb273df1df7b4b5e34738318b::sbond {
    struct SBOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOND>(arg0, 6, b"SBOND", b"SUI BOND", x"53554920424f4e4420e280932054686520636f6d6d756e697479207468617420646f65736ee280997420627265616b2e0a412073796d626f6c206f662073746179696e6720746f676574686572207768656e20535549207374727567676c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1780546768436.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

