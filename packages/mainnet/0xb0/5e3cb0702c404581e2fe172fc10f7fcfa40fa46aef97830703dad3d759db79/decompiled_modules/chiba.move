module 0xb05e3cb0702c404581e2fe172fc10f7fcfa40fa46aef97830703dad3d759db79::chiba {
    struct CHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBA>(arg0, 6, b"CHIBA", b"SUI CHIBA", x"4348494241202d20546865204f726967696e2053746f72790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_71_1b971091f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

