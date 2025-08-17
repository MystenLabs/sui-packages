module 0x4632f57466f4dd13e4e32d9a56d3832e7fe8b2ff1742262d1f250bcc145d5fd6::wifd {
    struct WIFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFD>(arg0, 9, b"WIFD", b"WifWifWifWifWif", b"WifWifWifWifWifWifWifWifWifWif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIFD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFD>>(v2, @0xfe5c8d34bf1319d0506ab9592b5ce5e1c283e38b3b12cecfd2d2bb4ab20dfff8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

