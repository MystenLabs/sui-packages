module 0x47331616072615f40c2cd6def3deae2b15954b299216c0d44c2b6e5fc2a345f7::rockysui {
    struct ROCKYSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROCKYSUI>, arg1: 0x2::coin::Coin<ROCKYSUI>) {
        0x2::coin::burn<ROCKYSUI>(arg0, arg1);
    }

    fun init(arg0: ROCKYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKYSUI>(arg0, 9, b"rockysui", b"rocky", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/VVceFnT.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKYSUI>>(v1);
        0x2::coin::mint_and_transfer<ROCKYSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKYSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROCKYSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ROCKYSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

