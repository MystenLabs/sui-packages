module 0xd6ea1c15acbf0ccc34fc418e4dc9fc36a25825ddff25916852cde65315ae0f2f::saped {
    struct SAPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPED>(arg0, 6, b"SAPED", b"SUI APED", b"$Saped is a cursed monkey had too much caffeine and then decided to crash the crypto. powered by a jolly chimp with a permanent banana overdose.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_68_dbffc3cf02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPED>>(v1);
    }

    // decompiled from Move bytecode v6
}

