module 0x5d796a2bef046df84eee258251edb449ab50a39c13115a009e72ebeba0b8dc4e::nexarc {
    struct NEXARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXARC>(arg0, 9, b"NEXARC", b"Nexa Reward Coin", b"The on-chain proof of reward for trading on the Nexa suite of trading products", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nexa.xyz/nexa-reward-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEXARC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXARC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

