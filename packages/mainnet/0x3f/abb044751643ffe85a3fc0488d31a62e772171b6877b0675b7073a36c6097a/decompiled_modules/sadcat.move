module 0x3fabb044751643ffe85a3fc0488d31a62e772171b6877b0675b7073a36c6097a::sadcat {
    struct SADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCAT>(arg0, 6, b"SADCAT", b"Sadcat", b"sadcat is so sad, now crying on Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/513_Pz_Mlr_MVL_AC_UF_894_1000_QL_80_fe9e57a0a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

