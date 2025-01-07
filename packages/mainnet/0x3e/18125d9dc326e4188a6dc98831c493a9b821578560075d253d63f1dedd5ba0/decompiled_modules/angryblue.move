module 0x3e18125d9dc326e4188a6dc98831c493a9b821578560075d253d63f1dedd5ba0::angryblue {
    struct ANGRYBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYBLUE>(arg0, 6, b"ANGRYBLUE", b"Angry blue guy", b"Just an angry blue guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6iswmw_f91e3f93c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

