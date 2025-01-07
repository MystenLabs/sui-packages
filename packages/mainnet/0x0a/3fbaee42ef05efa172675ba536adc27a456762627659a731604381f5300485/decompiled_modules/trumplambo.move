module 0xa3fbaee42ef05efa172675ba536adc27a456762627659a731604381f5300485::trumplambo {
    struct TRUMPLAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLAMBO>(arg0, 9, b"TRUMPLAMBO", b"trump lambo", b"Trump Lambo on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPLAMBO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLAMBO>>(v2, @0x154555df02ca1bd14de6d5796d446d630516e47aa8d8ba6143033dc24af715cd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPLAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

