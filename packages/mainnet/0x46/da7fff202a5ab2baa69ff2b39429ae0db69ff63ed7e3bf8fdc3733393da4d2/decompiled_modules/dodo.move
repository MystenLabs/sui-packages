module 0x46da7fff202a5ab2baa69ff2b39429ae0db69ff63ed7e3bf8fdc3733393da4d2::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 6, b"DoDo", b"DoDocute", b"Tiktok cute otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dudu_be97d48b73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

