module 0x6a69009117f45db783316981a02cf5ffe9647c4962e9618dc52225f3122a6b8::sui_wolf {
    struct SUI_WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_WOLF>(arg0, 9, b"SUI WOLF", b"Sui Wolf", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_WOLF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_WOLF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

