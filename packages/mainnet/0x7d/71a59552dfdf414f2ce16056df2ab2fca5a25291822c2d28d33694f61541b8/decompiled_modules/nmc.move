module 0x7d71a59552dfdf414f2ce16056df2ab2fca5a25291822c2d28d33694f61541b8::nmc {
    struct NMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMC>(arg0, 6, b"NMC", b"Namecoin", b"Namecoin was the first altcoin/cryptocurrency launched after Bitcoin in 2011 and now the first altcoin has become Memecoin!  $NMC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W4pog_Cd1o_NPXPR_41o_L_Mptp1_CPAD_Lj_B7p_V_Ar_Xdgppo_FZB_9ba8b267f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

