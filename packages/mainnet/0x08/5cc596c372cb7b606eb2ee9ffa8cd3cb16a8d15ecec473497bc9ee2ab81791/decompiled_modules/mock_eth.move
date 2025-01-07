module 0x85cc596c372cb7b606eb2ee9ffa8cd3cb16a8d15ecec473497bc9ee2ab81791::mock_eth {
    struct MOCK_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCK_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_ETH>(arg0, 8, b"ETH", b"Etherum", b"des", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_ETH>>(0x2::coin::mint<MOCK_ETH>(&mut v2, 1000000 * 0x2::math::pow(10, 8), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_ETH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

