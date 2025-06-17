module 0x9e4068ed3f700db5cfb37fa81c5d7100325b937f87721693eb1617fc8fd0e2d9::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA>(arg0, 9, b"AA", b"AA", b"fdgfdsffdsfdsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bananatool.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AA>>(v1);
    }

    // decompiled from Move bytecode v6
}

