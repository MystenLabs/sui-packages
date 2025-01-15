module 0x87ba105bb7c39e1ae8ce246d658daec43304930d493827eaf787fa3eac753e16::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"MalayAI by SuiAI", b"the first malaysian ai agent in suiAI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Firefly_1_Malaysian_hijab_women_pose_in_front_KLCC_petronas_62372_fa5e64ccc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

