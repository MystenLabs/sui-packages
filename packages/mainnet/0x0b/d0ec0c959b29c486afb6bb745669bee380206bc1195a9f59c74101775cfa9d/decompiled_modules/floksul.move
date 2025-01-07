module 0xbd0ec0c959b29c486afb6bb745669bee380206bc1195a9f59c74101775cfa9d::floksul {
    struct FLOKSUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKSUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKSUL>(arg0, 6, b"FLOKSUl", b"FLOKSUI", b"We're thrilled to have you join us as Floki takes its next big step onto the Sui Network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_193057325_3cb565d510.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKSUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKSUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

