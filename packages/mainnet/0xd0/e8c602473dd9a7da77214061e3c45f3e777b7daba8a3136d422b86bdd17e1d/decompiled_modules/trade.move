module 0xd0e8c602473dd9a7da77214061e3c45f3e777b7daba8a3136d422b86bdd17e1d::trade {
    struct TRADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRADE>(arg0, 6, b"TRADE", b"Ember Trade Finance", b"This receipt token represents the shares a user has of the Ember Trade Finance Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/TRADE.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRADE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

