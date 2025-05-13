module 0x9589a5c4b2aae3f0cbf4dfad896ac5b30bf720dfe78e08df501fafebe3fa2882::aisui {
    struct AISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUI>(arg0, 9, b"SUIAGENT", b"aiSUI", b"Groundbreaking AI Agent platform on SUInetwork, powered by $SUIAGENT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1876989779474071552/zk0gT0-1_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AISUI>>(0x2::coin::mint<AISUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AISUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

