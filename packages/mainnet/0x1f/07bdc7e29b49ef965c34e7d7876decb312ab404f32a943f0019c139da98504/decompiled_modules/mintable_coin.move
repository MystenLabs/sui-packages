module 0x1f07bdc7e29b49ef965c34e7d7876decb312ab404f32a943f0019c139da98504::mintable_coin {
    struct MINTABLE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINTABLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINTABLE_COIN>(arg0, 6, b"MTC", b"Mintable Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINTABLE_COIN>>(v1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MINTABLE_COIN>>(0x2::coin::mint<MINTABLE_COIN>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINTABLE_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun show_name() : vector<u8> {
        b"Mintable Coin"
    }

    // decompiled from Move bytecode v6
}

