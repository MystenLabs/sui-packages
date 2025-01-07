module 0x62ef3aae60f520d8338b3d43f208ef87c5ba4e0c6a89676f93f79f3ddc54f995::evens {
    struct EVENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVENS>(arg0, 9, b"EVENS", b"EVENS", b"EVENS coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVENS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVENS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

