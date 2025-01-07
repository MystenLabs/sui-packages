module 0xc50423af2f0d045c8b94b7ae7990cdf65150d973d4eb815fe3743900c6a3d917::shikoku {
    struct SHIKOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIKOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIKOKU>(arg0, 6, b"ShiKoKu", b"ShiKoKu DOgs", b"The power of the ShiKoKu dog brings the Japanese cultural symbol to the crypto space, bringing reliability and outstanding growth potential. Let's conquer new heights with ShiKoKu in the Sui market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1logo_bdee6d5473.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIKOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIKOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

