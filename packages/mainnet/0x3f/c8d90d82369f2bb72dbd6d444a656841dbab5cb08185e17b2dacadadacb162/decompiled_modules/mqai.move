module 0x3fc8d90d82369f2bb72dbd6d444a656841dbab5cb08185e17b2dacadadacb162::mqai {
    struct MQAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MQAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MQAI>(arg0, 6, b"MQAI", b"MetaQuestAI", x"4272696e67206e657720776f726c647320746f206c69666520776974682074686520706f776572206f662073706f6b656e20776f7264732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fykjz_GHP_400x400_eed5d33443.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MQAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MQAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

