module 0x1f83a164e50137c79157d2d6d7034ed9eb92e3a56e6d4791ca49c6c14a517e5d::catsuiaaa {
    struct CATSUIAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUIAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUIAAA>(arg0, 6, b"CATSUIAAA", b"CAT AAAAAAAAAA", x"492063616e27742073746f70207468696e6b696e672061626f7574205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PW_Tu_U_Vh_400x400_5fd9602465.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUIAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUIAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

