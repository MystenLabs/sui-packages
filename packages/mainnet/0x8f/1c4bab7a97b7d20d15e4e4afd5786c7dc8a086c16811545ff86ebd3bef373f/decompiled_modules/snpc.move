module 0x8f1c4bab7a97b7d20d15e4e4afd5786c7dc8a086c16811545ff86ebd3bef373f::snpc {
    struct SNPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNPC>(arg0, 6, b"SNPC", b"NPC in SUI", b"We are in the world of SUI. To each of us, everyone else is merely an NPC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NPC_078b5fdfa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

