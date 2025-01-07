module 0xd263b04142dc804dbf670ef5282c46a3346a8e872a66ebda0aafb7bd146ced92::galaxysui {
    struct GALAXYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALAXYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALAXYSUI>(arg0, 6, b"GALAXYSUI", b"GALAXY SUISUNG", x"22496e73706972652074686520576f726c642c204372656174652074686520467574757265220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_57_f84c33a5cc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALAXYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GALAXYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

