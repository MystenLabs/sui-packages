module 0x50d3eae8ee193a6ef0ea4a1e0347e8b5a1105a491256514d2efb78048cf493c9::safu {
    struct SAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFU>(arg0, 9, b"SAFU", b"SAFU", b"MARKED SAFU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/voloSUI.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

