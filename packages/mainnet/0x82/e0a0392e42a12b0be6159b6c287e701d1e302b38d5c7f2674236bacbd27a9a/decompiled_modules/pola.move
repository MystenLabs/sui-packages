module 0x82e0a0392e42a12b0be6159b6c287e701d1e302b38d5c7f2674236bacbd27a9a::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 6, b"POLA", b"POLA Bear", b"I'm the coldest, chillest, and funniest bear in the Arctic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Ox_Lm_Bh_A_400x400_9f7c93a92d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

