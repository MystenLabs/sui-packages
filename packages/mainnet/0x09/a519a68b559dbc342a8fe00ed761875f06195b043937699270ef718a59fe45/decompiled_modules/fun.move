module 0x9a519a68b559dbc342a8fe00ed761875f06195b043937699270ef718a59fe45::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 6, b"FUN", b"SuiFun", b"only for the fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifun_bdcc730683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

