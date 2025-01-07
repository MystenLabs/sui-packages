module 0x5f99f5be2fa07c3215bee4c260fd649ef3879bdb8f06103134d05f3ee044aafb::aaatrump {
    struct AAATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAATRUMP>(arg0, 6, b"AAATRUMP", b"Trump Supper", b"never give up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xik_FFNW_4_A_Aoc_Yw_c870526127.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

