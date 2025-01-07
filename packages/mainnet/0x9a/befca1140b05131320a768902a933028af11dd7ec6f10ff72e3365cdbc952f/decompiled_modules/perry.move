module 0x9abefca1140b05131320a768902a933028af11dd7ec6f10ff72e3365cdbc952f::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PERRY>, arg1: 0x2::coin::Coin<PERRY>) {
        0x2::coin::burn<PERRY>(arg0, arg1);
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 9, b"PERRY", b"PERRY the Platypus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/perry.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PERRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PERRY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

