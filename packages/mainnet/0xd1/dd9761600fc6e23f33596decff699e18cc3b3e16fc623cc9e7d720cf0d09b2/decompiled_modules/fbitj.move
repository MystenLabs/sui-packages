module 0xd1dd9761600fc6e23f33596decff699e18cc3b3e16fc623cc9e7d720cf0d09b2::fbitj {
    struct FBITJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBITJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBITJ>(arg0, 6, b"FBITJ", b"FBI to Jail", x"5468652046424920636f70792d706173746564207365766572616c206f66204f70656e5a657070656c696e2773206c6962726172696573202877686963682075736520746865204d4954204c6963656e73652920627574206469646e2774206861646520746865206c6963656e73652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_21_12_28_9c7d8bfef2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBITJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBITJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

