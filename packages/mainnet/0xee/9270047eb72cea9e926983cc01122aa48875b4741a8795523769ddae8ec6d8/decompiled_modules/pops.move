module 0xee9270047eb72cea9e926983cc01122aa48875b4741a8795523769ddae8ec6d8::pops {
    struct POPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPS>(arg0, 6, b"Pops", b"Popsui", b"The legendary meme coin on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma3r_Jj4_T1_Siy5_QJJJW_Zm_FK_Mjjba_GVWD_Bhs5641_SSXQV_Tn_a18c0545ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

