module 0x976091ab810a0a4d18fa862a2ec9b40e1ed661cc418f40a043a270382884ff57::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 9, b"CCC", b"CCC", b"ccSdsdsdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

