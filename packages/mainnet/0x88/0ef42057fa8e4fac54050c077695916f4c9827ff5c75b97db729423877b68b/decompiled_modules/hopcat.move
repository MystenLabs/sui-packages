module 0x880ef42057fa8e4fac54050c077695916f4c9827ff5c75b97db729423877b68b::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"HopCat", b"First cat on Turbos Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997075157.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

