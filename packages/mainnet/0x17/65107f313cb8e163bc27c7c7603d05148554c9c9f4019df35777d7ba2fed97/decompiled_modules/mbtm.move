module 0x1765107f313cb8e163bc27c7c7603d05148554c9c9f4019df35777d7ba2fed97::mbtm {
    struct MBTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBTM>(arg0, 6, b"MBTM", b"MBTMeow", b"Millions of Chains. Billions of People. Trillions of Tokens. - Meow Welcome to the Future Community creates the TG Community creates the Website Community creates the Twitter Community Creates Meme Channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nua_QUJHG_7h4njr_C7isz5mbxn_Vxcc_F_Mrmw3uu_Lr_NN_To6_F_a33b6e090a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

