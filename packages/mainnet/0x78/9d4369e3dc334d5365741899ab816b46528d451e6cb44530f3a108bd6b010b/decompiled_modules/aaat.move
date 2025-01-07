module 0x789d4369e3dc334d5365741899ab816b46528d451e6cb44530f3a108bd6b010b::aaat {
    struct AAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAT>(arg0, 6, b"AAAT", b"AAA Tiger", b"Tiger are more powerful than cat! https://t.me/AAATigerSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Clip_Down_1_ce2bdc7659.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

