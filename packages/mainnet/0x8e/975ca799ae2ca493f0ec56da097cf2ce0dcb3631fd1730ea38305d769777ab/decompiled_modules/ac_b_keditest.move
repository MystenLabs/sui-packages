module 0x8e975ca799ae2ca493f0ec56da097cf2ce0dcb3631fd1730ea38305d769777ab::ac_b_keditest {
    struct AC_B_KEDITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_KEDITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_KEDITEST>(arg0, 6, b"ac_b_keditest", b"TicketFortestkedi", b"Pre sale ticket of bonding curve pool for the following memecoin: testkedi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNtn1hxQZidxo45mPStSCLumY2A7RnPinJxmFsnTqDcz5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_KEDITEST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_KEDITEST>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_KEDITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

