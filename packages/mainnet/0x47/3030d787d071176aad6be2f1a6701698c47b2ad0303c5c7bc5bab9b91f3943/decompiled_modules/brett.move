module 0x473030d787d071176aad6be2f1a6701698c47b2ad0303c5c7bc5bab9b91f3943::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"Brett on Sui", b"Now, the spotlight is on $BRETT as he takes center stage to showcase his talents and rule the dance floor!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brett_2ea5c5802d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

