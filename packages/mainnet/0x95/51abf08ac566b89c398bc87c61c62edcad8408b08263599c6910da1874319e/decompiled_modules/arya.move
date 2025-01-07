module 0x9551abf08ac566b89c398bc87c61c62edcad8408b08263599c6910da1874319e::arya {
    struct ARYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARYA>(arg0, 9, b"ARYA", b"Aryan", b"Token for the individual", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARYA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARYA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

