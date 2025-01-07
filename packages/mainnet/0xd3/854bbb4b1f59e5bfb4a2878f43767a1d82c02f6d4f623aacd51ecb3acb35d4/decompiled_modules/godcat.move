module 0xd3854bbb4b1f59e5bfb4a2878f43767a1d82c02f6d4f623aacd51ecb3acb35d4::godcat {
    struct GODCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODCAT>(arg0, 6, b"GODCAT", b"GOD CAT", b"ts time for GODCAT to save everyone on Base chain. The ruler of mankind and all cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_28_21_46_12_fd601a1446.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

