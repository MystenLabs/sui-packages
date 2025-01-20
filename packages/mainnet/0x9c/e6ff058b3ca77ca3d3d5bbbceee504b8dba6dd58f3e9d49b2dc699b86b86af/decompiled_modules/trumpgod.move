module 0x9ce6ff058b3ca77ca3d3d5bbbceee504b8dba6dd58f3e9d49b2dc699b86b86af::trumpgod {
    struct TRUMPGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPGOD>(arg0, 6, b"TRUMPGOD", b"TRUMP GOD!!!", b"I am the savior of bags, I pump money into them, pump SUI, and deliver to you the finest memecoins to kick off the meme season! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Bvz9ngg_Nuj_G_Hdjd_Ptsi_AEDH_1k_Xzghqhcqxqb7_TV_Sdh2_df396fcb87.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

