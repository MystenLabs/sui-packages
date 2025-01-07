module 0xb744ae1345e7be66f187a822a89889e3e2ade37d7318993345323e1d60fd7e5f::fbi {
    struct FBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBI>(arg0, 6, b"FBI", b"NextFundAI", b"FBI created its own crypto token, \"NexFundAI\" to catch suspects for fraud and market manipulation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fbi_7b22dc1c4f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

