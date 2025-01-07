module 0x5cc68f07f9087408cbc0a61c8b1d9779bdb589eb01a24b9bd2b9c78c44671065::dogblue {
    struct DOGBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBLUE>(arg0, 6, b"DOGBLUE", b"blue eyed dog", b"A blue eyed dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m4_ZT_8t_Im_400x400_af74bb58f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

