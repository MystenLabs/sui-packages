module 0x736ba05b1d0cc64e597fc9f75a844b9f8504f53273c2180200fb4a5db9502780::hyungh {
    struct HYUNGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYUNGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYUNGH>(arg0, 6, b"HYUNGH", b"HYUUUUUUUUUNGH", b"HAYUUUUUUUUUUUUUUUUUUNGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hq720_ed28bdda61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYUNGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYUNGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

