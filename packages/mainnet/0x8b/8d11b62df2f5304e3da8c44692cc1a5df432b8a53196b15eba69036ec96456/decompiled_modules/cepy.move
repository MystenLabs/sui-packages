module 0x8b8d11b62df2f5304e3da8c44692cc1a5df432b8a53196b15eba69036ec96456::cepy {
    struct CEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPY>(arg0, 6, b"CEPY", b"CEPYBALA", b"We are the next top Memecoin on SUI !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_235327_fa7bedc53f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

