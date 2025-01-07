module 0x21ccbb0d5d7ce44d5ff1810dcf37f190bfb91f3647a4493b4686022d0ba15719::GOLDENEGGS {
    struct GOLDENEGGS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOLDENEGGS>, arg1: 0x2::coin::Coin<GOLDENEGGS>) {
        0x2::coin::burn<GOLDENEGGS>(arg0, arg1);
    }

    fun init(arg0: GOLDENEGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENEGGS>(arg0, 9, b"GOLDENEGGS", b"Golden Eggs", b"Ryan Coin Demo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-unfair-mackerel-372.mypinata.cloud/ipfs/QmYFh6RKLgYk8Ehx5HddTpgtdwN6KSVgjYrtRMKt1ojLrq")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDENEGGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENEGGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOLDENEGGS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOLDENEGGS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

