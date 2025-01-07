module 0x4e5634e1725d2e6804e34564b6e88f04538bf536999d9d9d80a066359f53d440::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"BOOSUI", x"426f6f206973206120667269656e646c79206275742073636172792067686f73740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DQSR_Lu_U1_400x400_7018acc484.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

