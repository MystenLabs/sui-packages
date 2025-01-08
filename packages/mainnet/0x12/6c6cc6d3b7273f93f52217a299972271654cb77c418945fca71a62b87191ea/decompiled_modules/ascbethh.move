module 0x126c6cc6d3b7273f93f52217a299972271654cb77c418945fca71a62b87191ea::ascbethh {
    struct ASCBETHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASCBETHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASCBETHH>(arg0, 9, b"ASCBETHH", b"ASCBETH", b"SAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASCBETHH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASCBETHH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASCBETHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

