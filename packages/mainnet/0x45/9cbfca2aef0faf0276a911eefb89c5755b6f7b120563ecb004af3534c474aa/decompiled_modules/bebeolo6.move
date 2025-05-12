module 0x459cbfca2aef0faf0276a911eefb89c5755b6f7b120563ecb004af3534c474aa::bebeolo6 {
    struct BEBEOLO6 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO6>, arg1: 0x2::coin::Coin<BEBEOLO6>) {
        0x2::coin::burn<BEBEOLO6>(arg0, arg1);
    }

    fun init(arg0: BEBEOLO6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBEOLO6>(arg0, 2, b"BEBEOLO6", b"ktoiet4", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBEOLO6>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBEOLO6>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEBEOLO6>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

