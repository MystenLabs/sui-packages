module 0x3b9f65ca7b419b9c094689bb0af0116a0c5711487f7b197615632f510688ec92::suirf {
    struct SUIRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRF>(arg0, 6, b"SUIRF", b"Suirf", b"Oh Fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suirf_1feec8f58d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

