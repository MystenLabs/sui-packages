module 0xb70b56075e4d2c4ec3e17d9e810a29c36ffe2475f035d3894a4e381d2ee1805a::catgirl {
    struct CATGIRL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATGIRL>, arg1: 0x2::coin::Coin<CATGIRL>) {
        0x2::coin::burn<CATGIRL>(arg0, arg1);
    }

    fun init(arg0: CATGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGIRL>(arg0, 2, b"CATGIRL", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATGIRL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CATGIRL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

