module 0xed9c28bb010242a509bf57e60121fdb54c90449108ef6cfca551b256639edd69::sportrait {
    struct SPORTRAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPORTRAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPORTRAIT>(arg0, 6, b"SPORTRAIT", b"SELF  PORTRAIT", x"48692c206d79206e616d652069732073696c6f0a49276d20616e20696c6c7573747261746f722c20490a6d616465206d7920696d61676520776974680a6d792070657473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_11_04_A_s_22_10_42_4013f109_468fef2ae1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPORTRAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPORTRAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

