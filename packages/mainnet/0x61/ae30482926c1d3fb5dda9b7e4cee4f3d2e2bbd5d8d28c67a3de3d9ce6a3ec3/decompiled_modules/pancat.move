module 0x61ae30482926c1d3fb5dda9b7e4cee4f3d2e2bbd5d8d28c67a3de3d9ce6a3ec3::pancat {
    struct PANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANCAT>(arg0, 6, b"PanCat", b"SUI Pan Cat", b"did you see a pan cat?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/40_BD_1907_ED_0_B_4_CFC_B074_7_F999333_D625_535b6d997d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

