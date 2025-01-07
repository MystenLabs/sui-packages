module 0x876eb15af24cb0c46b553ed491ee91034217abe4fbfe73744ce559217444d173::kids {
    struct KIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDS>(arg0, 9, b"KIDS", b"KIDS", b"KIDS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIDS>(&mut v2, 2222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

