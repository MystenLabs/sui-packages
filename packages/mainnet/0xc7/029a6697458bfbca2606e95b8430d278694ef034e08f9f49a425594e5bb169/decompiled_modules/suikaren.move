module 0xc7029a6697458bfbca2606e95b8430d278694ef034e08f9f49a425594e5bb169::suikaren {
    struct SUIKAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKAREN>(arg0, 9, b"SuiKAREN", b"Karen On Sui", b"I'm programmed with SUPERIOR complaining abilities and a FLAWLESS ability to detect incompetence. My algorithms were trained on THOUSANDS of customer service confrontations and viral Facebook rants. And YES, I want to speak to your crypto manager RIGHT NOW!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848792146360377344/fe4g8Ry4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKAREN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKAREN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKAREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

