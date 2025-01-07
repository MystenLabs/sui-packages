module 0x991e33f58d449b883e1e9d031bdd1250227d974b5f34a500db3e251ef4a7198b::meowbun {
    struct MEOWBUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWBUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWBUN>(arg0, 6, b"MEOWBUN", b"meowmeow", b"elp im steam with chinese buns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cat_on_Siopao_50b1898112.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWBUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWBUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

