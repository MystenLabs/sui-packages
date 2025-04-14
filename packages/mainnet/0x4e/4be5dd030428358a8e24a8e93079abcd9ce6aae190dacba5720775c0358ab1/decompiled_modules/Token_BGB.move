module 0x4e4be5dd030428358a8e24a8e93079abcd9ce6aae190dacba5720775c0358ab1::Token_BGB {
    struct TOKEN_BGB has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN_BGB>, arg1: 0x2::coin::Coin<TOKEN_BGB>) {
        0x2::coin::burn<TOKEN_BGB>(arg0, arg1);
    }

    fun init(arg0: TOKEN_BGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_BGB>(arg0, 9, b"TOKEN_B", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_BGB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_BGB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN_BGB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN_BGB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

