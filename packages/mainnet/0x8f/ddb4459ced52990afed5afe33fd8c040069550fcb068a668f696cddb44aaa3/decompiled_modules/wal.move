module 0x8fddb4459ced52990afed5afe33fd8c040069550fcb068a668f696cddb44aaa3::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 6, b"WAL", b"stakewal", b"wal from stake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2025_05_16_a_I_s_15_49_09_466bb99bcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

