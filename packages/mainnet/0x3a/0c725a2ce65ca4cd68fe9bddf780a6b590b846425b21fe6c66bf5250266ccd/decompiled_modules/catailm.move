module 0x3a0c725a2ce65ca4cd68fe9bddf780a6b590b846425b21fe6c66bf5250266ccd::catailm {
    struct CATAILM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAILM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAILM>(arg0, 6, b"CatAILM", b"CatAI Agent Language Model", b"CatAI Agent Language Model is an intelligent AI agent designed to assist, adapt, and make your tasks easier with seamless efficiency and a user-friendly approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/359f684a_e6e0_46db_b11f_1ffc05973291_effb07230f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAILM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAILM>>(v1);
    }

    // decompiled from Move bytecode v6
}

