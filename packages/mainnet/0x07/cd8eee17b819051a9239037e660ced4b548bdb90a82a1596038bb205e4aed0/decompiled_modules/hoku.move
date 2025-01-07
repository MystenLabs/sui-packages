module 0x7cd8eee17b819051a9239037e660ced4b548bdb90a82a1596038bb205e4aed0::hoku {
    struct HOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOKU>(arg0, 6, b"Hoku", b"Hokulea", b"Hokulea the famous surfing cat of Hawaii, now taking on the waves of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/surfer_cat_19391d8a18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

