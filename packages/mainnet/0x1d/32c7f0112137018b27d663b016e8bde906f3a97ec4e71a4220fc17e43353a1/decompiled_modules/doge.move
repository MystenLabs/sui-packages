module 0x1d32c7f0112137018b27d663b016e8bde906f3a97ec4e71a4220fc17e43353a1::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Department Of Government Efficiency", x"5472756d70206170706f696e74656420456c6f6e20746f206c6561642074686520442e4f2e472e450a5765627369746520636f6d696e6720736f6f6e210a4c46472121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogeee_30c5386448.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

