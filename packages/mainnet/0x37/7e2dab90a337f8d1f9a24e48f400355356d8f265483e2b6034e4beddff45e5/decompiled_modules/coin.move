module 0x377e2dab90a337f8d1f9a24e48f400355356d8f265483e2b6034e4beddff45e5::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: 0x2::coin::Coin<COIN>) {
        0x2::coin::burn<COIN>(arg0, arg1);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 2, b"Target $1,000,000", b"$MILLION", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreialtuvrpu4af4zgejgs4autcz2vzwqiwoympskfg57paynvxag2ni.ipfs.nftstorage.link")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

