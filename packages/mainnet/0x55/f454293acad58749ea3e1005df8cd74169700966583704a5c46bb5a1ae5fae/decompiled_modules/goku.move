module 0x55f454293acad58749ea3e1005df8cd74169700966583704a5c46bb5a1ae5fae::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"Goku On Sui", x"476f6b75204a6f696e73207468652053756920426c6f636b636861696e20556e697665727365210a0a57687920476f6b753f20576879205375693f0a0a4b612e2e2e204d652e2e2e2048612e2e2e204d652e2e2e20484121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e5c9b275_8018_42c7_9dce_e98b837bf709_8f99a2c7ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

