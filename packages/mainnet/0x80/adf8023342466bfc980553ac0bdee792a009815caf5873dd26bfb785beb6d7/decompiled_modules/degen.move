module 0x80adf8023342466bfc980553ac0bdee792a009815caf5873dd26bfb785beb6d7::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 6, b"Degen", b"Degen Apes", b"just Degens trying to ape... No emotions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Degen_Apes_5906b7822c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

