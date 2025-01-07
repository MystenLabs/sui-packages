module 0x652c6dfcae2c8fca8a405ef6ed0c3c6994c70b1c304dc5aced6dc557358f3a72::thomahuer_coin {
    struct THOMAHUER_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THOMAHUER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THOMAHUER_COIN>>(0x2::coin::mint<THOMAHUER_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: THOMAHUER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<THOMAHUER_COIN>(arg0, 8, b"THOMAHUER", b"THOMAHUER Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOMAHUER_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<THOMAHUER_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THOMAHUER_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

