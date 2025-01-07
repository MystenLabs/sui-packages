module 0x4d00378a98c8c41369d75fc85745f56990c6705aa1dab807c27cb6f97cb0af93::scope {
    struct SCOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOPE>(arg0, 6, b"SCOPE", b"Scopecoon", b"Scopecoin is a token designed for the community, and right now we are excited to build together, the community is free and there are no rules $SCOPE All to community Growth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036955_e0139dd673.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

