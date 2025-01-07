module 0xd60c4c77c05e6d0c8895bc242ff7bef073ffcc70a7d87028a44b7c4e08dcddeb::frogai {
    struct FROGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGAI>(arg0, 6, b"FROGAI", b"FROG AI", x"46697273742041492d64726976656e206d656d65636f696e2066726f6720657665722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_16_204641_bd303cdd05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

