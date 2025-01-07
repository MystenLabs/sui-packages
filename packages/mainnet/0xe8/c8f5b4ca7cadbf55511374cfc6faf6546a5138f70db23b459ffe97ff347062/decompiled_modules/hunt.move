module 0xe8c8f5b4ca7cadbf55511374cfc6faf6546a5138f70db23b459ffe97ff347062::hunt {
    struct HUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNT>(arg0, 6, b"HUNT", b"HunterXHunter", b"Hunt this you'll get rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WIF_Token_sol_Deth_Code_1892f1e712.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

