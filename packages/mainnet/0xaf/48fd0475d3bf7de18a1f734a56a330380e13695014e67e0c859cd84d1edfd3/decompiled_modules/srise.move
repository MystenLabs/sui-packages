module 0xaf48fd0475d3bf7de18a1f734a56a330380e13695014e67e0c859cd84d1edfd3::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE", b"AI Agent _/ HypeAgent of $SUI Ecosystem | Entirely independent. Custom-built technology & utilizing Retrieval Augmented Generation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_V_Jhz_N5_L_400x400_269c647c5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

