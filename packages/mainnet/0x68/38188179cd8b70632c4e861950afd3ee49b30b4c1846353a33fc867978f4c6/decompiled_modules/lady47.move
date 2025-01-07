module 0x6838188179cd8b70632c4e861950afd3ee49b30b4c1846353a33fc867978f4c6::lady47 {
    struct LADY47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADY47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADY47>(arg0, 6, b"Lady47", b"Milady47", x"426568696e64206576657279207374726f6e67206d616e2074686572652069732061204d696c616479210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_T_Nmtu_K3_Nx_Qk_t_Kvuy_Wl_5j_O27vr26q0c_Rk_Lv5cz_E_69f5e11d40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADY47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADY47>>(v1);
    }

    // decompiled from Move bytecode v6
}

