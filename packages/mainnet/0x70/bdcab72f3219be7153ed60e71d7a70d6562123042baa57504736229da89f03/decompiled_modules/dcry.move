module 0x70bdcab72f3219be7153ed60e71d7a70d6562123042baa57504736229da89f03::dcry {
    struct DCRY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DCRY>, arg1: 0x2::coin::Coin<DCRY>) {
        0x2::coin::burn<DCRY>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DCRY>>(0x2::coin::mint<DCRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCRY>(arg0, 9, b"DCRY", b"DCRY", b"DCRY Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://orange-selected-goose-622.mypinata.cloud/ipfs/bafybeigjdgeh3oms2suyq7deltgxjewjrm7hda37gfcwezd7rj633gtpwm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DCRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

