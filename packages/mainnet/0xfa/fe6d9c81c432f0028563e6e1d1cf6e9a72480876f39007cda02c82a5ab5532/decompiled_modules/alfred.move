module 0xfafe6d9c81c432f0028563e6e1d1cf6e9a72480876f39007cda02c82a5ab5532::alfred {
    struct ALFRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALFRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALFRED>(arg0, 6, b"ALFRED", b"Alfred On Sui", b"Experience ALFRED Exciting Journey on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4nxwwk_7f66042ca0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALFRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALFRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

