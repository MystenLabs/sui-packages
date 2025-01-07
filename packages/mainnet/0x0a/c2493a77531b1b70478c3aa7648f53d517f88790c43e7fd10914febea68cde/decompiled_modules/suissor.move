module 0xac2493a77531b1b70478c3aa7648f53d517f88790c43e7fd10914febea68cde::suissor {
    struct SUISSOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSOR>(arg0, 6, b"SUISSOR", b"SUISS0R", b"Dont Get Cut!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_04_33_38_d56a1ebb8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

