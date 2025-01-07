module 0x84d75812a2dd02b7e8366d9ef3317b0f19e7775ab01159f46ac00208b2b73044::bape {
    struct BAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPE>(arg0, 6, b"BAPE", b"Brett Ape", b"Brett Ape has come to overtake all apes on the Sui Network! Hide your apes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_min_3fc7dccac3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

