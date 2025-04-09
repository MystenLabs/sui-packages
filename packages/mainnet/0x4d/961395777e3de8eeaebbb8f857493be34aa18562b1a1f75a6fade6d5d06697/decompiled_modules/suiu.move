module 0x4d961395777e3de8eeaebbb8f857493be34aa18562b1a1f75a6fade6d5d06697::suiu {
    struct SUIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIU>(arg0, 9, b"SUIU", b"SUIU", b"SUIU safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/musd.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

