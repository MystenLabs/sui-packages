module 0xc3de428539565e7d6bdb0fa4f13862414447128cf16e3e57ee188e86dea22da9::safud {
    struct SAFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFUD>(arg0, 7, b"SAFUD", b"SAFUD", b"MARKED SAFU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/voloSUI.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFUD>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

