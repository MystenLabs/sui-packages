module 0x676b0f2d6ebe90e37f26b969883ea5d1275d1a6ff87681c534c238a8aff8a4e0::safutwo {
    struct SAFUTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFUTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFUTWO>(arg0, 7, b"SAFUTWO", b"SAFU2", b"MARKED SAFU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/voloSUI.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFUTWO>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFUTWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFUTWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

