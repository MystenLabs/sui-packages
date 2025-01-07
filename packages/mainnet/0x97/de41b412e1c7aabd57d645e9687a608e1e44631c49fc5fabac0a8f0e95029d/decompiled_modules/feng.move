module 0x97de41b412e1c7aabd57d645e9687a608e1e44631c49fc5fabac0a8f0e95029d::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENG>(arg0, 6, b"FENG", b"Feng Sui", x"46656e672073756920697320746865207072616374696365206f6620617272616e67696e672070696563657320696e20576562332073706163657320746f206372656174652062616c616e6365207769746820746865205669727475616c20776f726c642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/feng_0cc1b9b45b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

