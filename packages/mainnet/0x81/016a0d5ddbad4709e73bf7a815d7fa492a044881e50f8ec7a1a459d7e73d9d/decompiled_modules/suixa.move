module 0x81016a0d5ddbad4709e73bf7a815d7fa492a044881e50f8ec7a1a459d7e73d9d::suixa {
    struct SUIXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXA>(arg0, 0, b"SuixA", b"The SuixA", b"This is SuixA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bizweb.dktcdn.net/thumb/grande/100/463/551/products/ghim-cai-quan-ao-hinh-con-meo-them-hoa-tiet-ngon-lua.jpg?v=1697609881703")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXA>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

