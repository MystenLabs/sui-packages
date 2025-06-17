module 0x3e380ac69038be50e186cdd5278f193181e3bfe789d7d7d544e104d993e989ed::yy {
    struct YY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YY>(arg0, 9, b"YY", b"YY", b"CC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bananatool.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YY>>(v1);
    }

    // decompiled from Move bytecode v6
}

