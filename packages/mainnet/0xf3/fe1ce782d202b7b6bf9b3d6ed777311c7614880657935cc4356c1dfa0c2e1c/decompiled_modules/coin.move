module 0xf3fe1ce782d202b7b6bf9b3d6ed777311c7614880657935cc4356c1dfa0c2e1c::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 9, b"asdfg", b"asdfg", b"asdfg is test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/logos/asdfg.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

