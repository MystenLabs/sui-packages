module 0x1055ae17592c72c0a64e5add3838fa80399ade581fc0ce6393a4979f08c1df8c::for {
    struct FOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOR>(arg0, 9, b"FOR", b"Fuck of Run", b"jdjddjdddjdjjdjdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOR>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

