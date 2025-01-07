module 0x371e80482c6d8d4ffd11ea2442c7498cddecf522df6335559dbfb4ccb5f2d12f::aruzesui {
    struct ARUZESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARUZESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARUZESUI>(arg0, 6, b"ARUZESUI", b"ARUZE ON SUI", b"A pigeon Aruze explores the world of Sui, meets new friends and goes on exciting adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_39193f9340.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARUZESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARUZESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

