module 0xcc2e9ba559e848b518f71ed50448878e59868404bd935e2776b359a24909f851::pruto {
    struct PRUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRUTO>(arg0, 6, b"Pruto", b"Pruto  & friends", b"pruto & friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_c180d51e5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

