module 0x38a115558cb9617bbdccc8a784f024915447ec62cd5a364ab8d4f4a80de9c4ec::shsf {
    struct SHSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHSF>(arg0, 9, b"SHSF", b"rejfkgsjg", b"fgjsklfgjkdfjgk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHSF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHSF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

