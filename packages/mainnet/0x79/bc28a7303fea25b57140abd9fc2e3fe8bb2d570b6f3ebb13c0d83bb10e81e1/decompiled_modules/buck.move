module 0x79bc28a7303fea25b57140abd9fc2e3fe8bb2d570b6f3ebb13c0d83bb10e81e1::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 6, b"BUCK", b"Buck drive car", b"https://x.com/BuckOnTwidder/status/1844391854701461956", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_164647_cf9b4d62a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

