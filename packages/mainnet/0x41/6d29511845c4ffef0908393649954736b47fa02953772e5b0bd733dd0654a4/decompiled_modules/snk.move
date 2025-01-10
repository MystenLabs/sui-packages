module 0x416d29511845c4ffef0908393649954736b47fa02953772e5b0bd733dd0654a4::snk {
    struct SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNK>(arg0, 6, b"SNK", b"skeleton king by SuiAI", b"A very powerful and durable hero, suitable for playing as a core output or tank character in the later stages of the game. His skills enable him to fight persistently in battles and play an important role in team battles through his resurrection skills.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/snk_058b461d10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

