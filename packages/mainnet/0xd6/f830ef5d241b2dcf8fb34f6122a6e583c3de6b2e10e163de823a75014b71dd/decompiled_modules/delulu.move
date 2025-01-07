module 0xd6f830ef5d241b2dcf8fb34f6122a6e583c3de6b2e10e163de823a75014b71dd::delulu {
    struct DELULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELULU>(arg0, 6, b"DELULU", b"deluludog", b"are u delulu ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deluludog_928b7f26b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELULU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELULU>>(v1);
    }

    // decompiled from Move bytecode v6
}

