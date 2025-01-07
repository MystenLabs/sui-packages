module 0xb19c93aa11f604029dd3da8875fe33a3862905e920b0aabf6aed04cf59f1101d::rclm {
    struct RCLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCLM>(arg0, 9, b"RCLM", b"randomClmm", b"sdsdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RCLM>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCLM>>(v2, @0x7d6c2ac6a6f3df08d8a40900c1d1197abd95330561cc1f83eee933686b0ea94);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

