module 0xe1d65fc34158a388c200eebf2797de3750d44f52c87e9ef90bf1dc03ad54df99::blastar {
    struct BLASTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTAR>(arg0, 6, b"BLASTAR", b"BLASTAR TRIBUTE", b"Elon Musk's first project. A tribute to the 40th anniversary of Blastar's creation. Blastar was a game written by Elon Musk in 1984 (at the age of 12). The source code was published in a magazine and he received $500 for it. Play online (HTML 5 version) - https://blastar-1984.appspot.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Pt_H_Bg_W8_A_Ai77g_7843d2a64b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

