module 0x94a96cd6a5a1209d9a21d0124698b3d9f6c8b2973a880b23682d59ddf5bc8d60::boom_coin {
    struct BOOM_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM_COIN>(arg0, 9, b"boom", b"boom coin", b"just booming. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/6b0ccdff-f394-4df6-bbc0-918cb0e0e623.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

