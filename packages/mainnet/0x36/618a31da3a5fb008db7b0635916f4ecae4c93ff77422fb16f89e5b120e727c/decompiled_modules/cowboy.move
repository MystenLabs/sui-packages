module 0x36618a31da3a5fb008db7b0635916f4ecae4c93ff77422fb16f89e5b120e727c::cowboy {
    struct COWBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWBOY>(arg0, 6, b"COWBOY", b"Charlie", b"This wild west rascal is on a mission to wrangle up every no good varmit, scoundrel, and cowpoke this side of the mississippi. Charlie is the dog we need for the new frontiers, yeehaw!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bvdu_S_Vu2_Xebc_Po7u_AKYTK_2e_Kpz_J9_A8s1r_RM_Lk_X1u7_M9_E_80840d593d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COWBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

