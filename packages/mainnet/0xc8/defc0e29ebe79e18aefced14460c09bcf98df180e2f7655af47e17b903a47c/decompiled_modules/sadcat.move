module 0xc8defc0e29ebe79e18aefced14460c09bcf98df180e2f7655af47e17b903a47c::sadcat {
    struct SADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCAT>(arg0, 6, b"SADCAT", b"SADCAT ON SUI", b"SADCAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HDY_Je_Mymk4_Zo_Qazo_Zv_Mg4_Jvx_A_Gye8i_Kh7_U1qh_Z9e_Zw_Px_da2e42f6b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

