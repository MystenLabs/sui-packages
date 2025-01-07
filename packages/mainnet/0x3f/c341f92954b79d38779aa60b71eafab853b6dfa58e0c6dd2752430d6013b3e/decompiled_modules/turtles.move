module 0x3fc341f92954b79d38779aa60b71eafab853b6dfa58e0c6dd2752430d6013b3e::turtles {
    struct TURTLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLES>(arg0, 6, b"TURTLES", b"I like Turtles", x"547572746c6573206172652067656e746c6520736561206372656174757265732074686174206765742074616e676c656420696e2066697368696e67206e65747320616e64206e656564206f75722068656c700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wkgqerpgqytnca7f_KQY_3rkzx_Mgtwt_Tp27sy7_N6nza3_Hp_1a40ea0c88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

