module 0xa5702a6e6fbf2856611cfd0f58358224574a89f9bc8ffa9ba60201b6d8bbe5ae::cyber {
    struct CYBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBER>(arg0, 6, b"CYBER", b"Cyber", b"The blockchain for Social | Making web3 more social by bringing new users & experiences onchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/84_Pr_Un_Nr_400x400_Photoroom_9b72f54783.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

