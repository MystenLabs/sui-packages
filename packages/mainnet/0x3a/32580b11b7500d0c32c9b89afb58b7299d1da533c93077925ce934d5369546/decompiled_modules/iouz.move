module 0x3a32580b11b7500d0c32c9b89afb58b7299d1da533c93077925ce934d5369546::iouz {
    struct IOUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOUZ>(arg0, 9, b"IOUZ", b"IOU333", b"IOUUUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://search.app.goo.gl/X5cqB5L")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IOUZ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOUZ>>(v2, @0x4b69860905775e037ed0508a455b073e32686490319557f0b80cb7f1f2bda376);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

