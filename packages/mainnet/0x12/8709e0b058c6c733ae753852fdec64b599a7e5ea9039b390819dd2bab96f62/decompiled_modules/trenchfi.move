module 0x128709e0b058c6c733ae753852fdec64b599a7e5ea9039b390819dd2bab96f62::trenchfi {
    struct TRENCHFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHFI>(arg0, 6, b"Trenchfi", b"Trenches", b"Let the sui trenches come alive  here, no site, no TG,  No X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigerpltdnmc7yqx6dvhycvk2qf5q2k6zcoatrfw47j36x74ju4ylq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRENCHFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

