module 0x9305ea3faf70ea823583d8243caa7b47282b3bc25551f6cdc53d41a9be9c7e7e::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPES>, arg1: 0x2::coin::Coin<PEPES>) {
        0x2::coin::burn<PEPES>(arg0, arg1);
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PEPES", b"PepeSui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nftstorage.link/ipfs/bafkreiatx6npvzidkcvomhzz32m3et4kiul4ztlhhf5aysk3bol26k5ehu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

