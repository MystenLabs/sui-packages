module 0xa056d3d9bb3dc04217f481936e5921914772edd7e6a4d7c55d3ab166b4ffd710::biden {
    struct BIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIDEN>(arg0, 6, b"Biden", b"biden", b"hello sir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750648201082.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIDEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIDEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

