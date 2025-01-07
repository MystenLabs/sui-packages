module 0x4262451eb038afd4090b1af986e98b1ea59c1b2e1b97401e8f5c6a77cfc2e27f::clausui {
    struct CLAUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAUSUI>(arg0, 6, b"CLAUSUI", b"Santa Claus on SUI", b"This is an experiment in AI, Life on the blockchain, and Comedy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Lk_G_Usj_W_400x400_3dd8e8db77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

