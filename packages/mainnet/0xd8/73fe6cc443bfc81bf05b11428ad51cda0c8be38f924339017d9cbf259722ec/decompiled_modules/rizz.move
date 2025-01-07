module 0xd873fe6cc443bfc81bf05b11428ad51cda0c8be38f924339017d9cbf259722ec::rizz {
    struct RIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZ>(arg0, 6, b"RIZZ", b"SUIRIZZ", b"W RIZZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_pepe_021b854be6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

