module 0xeb0177c25c929852c062928bfc0281979cb965c311859df470175de99d152d68::trumphin {
    struct TRUMPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPHIN>(arg0, 6, b"Trumphin", b"Dolphin Trump", b"dolphin donald trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfsddg_bbe8bb7d59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

