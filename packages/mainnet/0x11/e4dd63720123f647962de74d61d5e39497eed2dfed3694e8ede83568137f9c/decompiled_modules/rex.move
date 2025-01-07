module 0x11e4dd63720123f647962de74d61d5e39497eed2dfed3694e8ede83568137f9c::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"$REX", b"$REX", x"73752d72c99b6b732e20536f6d657468696e672062696720616e6420626c756520697320636f6d696e67206578636c75736976656c7920746f2040686f7061676772656761746f722e2049e280996d205265782c207765e28099726520616c6c20526578e280a62e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-accurate-ermine-64.mypinata.cloud/ipfs/QmfW8wUUfQhmibemy7iteThTA4V1ovJboN5DE7AhX65cfz")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REX>>(0x2::coin::mint<REX>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REX>>(v2);
    }

    // decompiled from Move bytecode v6
}

