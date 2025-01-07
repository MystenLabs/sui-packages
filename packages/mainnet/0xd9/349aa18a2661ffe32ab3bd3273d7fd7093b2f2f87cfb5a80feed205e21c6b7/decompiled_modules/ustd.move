module 0xd9349aa18a2661ffe32ab3bd3273d7fd7093b2f2f87cfb5a80feed205e21c6b7::ustd {
    struct USTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USTD>(arg0, 6, b"USTD", b"Teter", b"To won dollah u degeneraz, the new meta is here, and is ours, together united to make history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_5c3fb7a7f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

