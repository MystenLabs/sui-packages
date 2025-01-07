module 0x5e607f6a7531f48ff0a3d35e49703559dfedbd88cae62d3d21437dc89f0fe111::arnt {
    struct ARNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARNT>(arg0, 9, b"ARNT", b"ARNT", b"Are Robots Not Tank", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/HONDA_ASIMO.jpg/640px-HONDA_ASIMO.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARNT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARNT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

