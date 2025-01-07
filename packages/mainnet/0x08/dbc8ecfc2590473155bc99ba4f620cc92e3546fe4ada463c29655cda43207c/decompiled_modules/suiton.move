module 0x8dbc8ecfc2590473155bc99ba4f620cc92e3546fe4ada463c29655cda43207c::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITON>, arg1: 0x2::coin::Coin<SUITON>) {
        0x2::coin::burn<SUITON>(arg0, arg1);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<SUITON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITON>>(0x2::coin::split<SUITON>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 9, b"SUITON", b"Tobirama's no jutsu", b"It's all the Uchiha's fault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-elderly-mink-482.mypinata.cloud/ipfs/QmXEvvxqezzX2v53cFYo8FZyPUKQNzZAJw29Q86SVHjUnA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

