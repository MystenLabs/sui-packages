module 0x172a6a364fd76b153bcb592857af0a628f1405f1d208aec2d550be865cd536c5::angry_than_ur_gf {
    struct ANGRY_THAN_UR_GF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRY_THAN_UR_GF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ANGRY_THAN_UR_GF>(arg0, 23970058985376126, b"angy CAT", b"Angry than ur gf", b"Just MEME, angry cat MEME and just love CAATTT", b"https://images.hop.ag/ipfs/Qma69RxKsBrbmvmU3HRFaeQ2NELTvXRtFCdhX9giffkmTP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

