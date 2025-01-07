module 0x6898218255be15ba1acceba035716824b7dda91837297de0ee9ca2a7ba305a93::teddy {
    struct TEDDY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEDDY>, arg1: 0x2::coin::Coin<TEDDY>) {
        0x2::coin::burn<TEDDY>(arg0, arg1);
    }

    fun init(arg0: TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDDY>(arg0, 6, b"TEDDY BEAR", b"TEDDY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/RBxCq4n/teddy.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEDDY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEDDY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

