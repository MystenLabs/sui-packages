module 0xb54a07e8598ad2a9f24d44eab053f9441d88512c7ed66d14d975d6be5300a08f::est31 {
    struct EST31 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST31, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST31>(arg0, 6, b"EST31", b"testing11", b"dfs asfd a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1739371428316-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST31>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST31>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

