module 0x6f4f3523f7da571e70370ea801a6b307760647d3f2e7cbf722410380ccc1e0ed::keditest {
    struct KEDITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEDITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEDITEST>(arg0, 6, b"keditest", b"testkedi", b"ahahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNtn1hxQZidxo45mPStSCLumY2A7RnPinJxmFsnTqDcz5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEDITEST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEDITEST>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEDITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

