module 0xa14dc46dff0919ef31037ab7e0a300302210dc67a369553cf01996c3dfbb8316::dontbuyit {
    struct DONTBUYIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUYIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUYIT>(arg0, 9, b"DONTBUYIT", b"DONTBUYIT", b"Do not buy it!!!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://as2.ftcdn.net/v2/jpg/02/13/55/85/1000_F_213558530_ljszuEb8or1T4JzymjAevPJzHrqrPZB1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONTBUYIT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUYIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUYIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

