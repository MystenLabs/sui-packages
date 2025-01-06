module 0xa9c7e8c9a0d3b3500b0620f99a7eb673cc0fe04531bc45b81ab770aef862ee86::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"POSUIDON", b"PoSUIdon", b"PoSUIdon the Lord of all Seas and Oceans the real OG of Atlantis put some respect on his name when you are talking to him!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_0fc249a0ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

