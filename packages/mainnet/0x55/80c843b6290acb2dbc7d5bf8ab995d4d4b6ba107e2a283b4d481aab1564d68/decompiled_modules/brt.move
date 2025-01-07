module 0x5580c843b6290acb2dbc7d5bf8ab995d4d4b6ba107e2a283b4d481aab1564d68::brt {
    struct BRT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRT>, arg1: 0x2::coin::Coin<BRT>) {
        0x2::coin::burn<BRT>(arg0, arg1);
    }

    fun init(arg0: BRT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRT>(arg0, 6, b"BRT", b"Bankrupt", b"The root problem with conventional currencies is all the trust that's required to make it work. The central bank must be trusted not to debase the currency, but the history of fiat currencies is full of breaches of that trust. And that's how cryptocurrency was born. - Satoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibxug6ipdh4dsk5gnudzqofk7oszibs2yrasoatibgvg333smuzqq.ipfs.nftstorage.link")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRT>>(v2);
        let v4 = &mut v3;
        mint(v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRT>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BRT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

