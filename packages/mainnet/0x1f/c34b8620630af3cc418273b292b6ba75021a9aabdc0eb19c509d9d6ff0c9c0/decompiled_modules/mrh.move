module 0x1fc34b8620630af3cc418273b292b6ba75021a9aabdc0eb19c509d9d6ff0c9c0::mrh {
    struct MRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRH>(arg0, 6, b"MRH", b"merih", b"parallel star wars universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Vx_F44_Wo_A_Aeu_PK_9ddb75bb56.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRH>>(v1);
    }

    // decompiled from Move bytecode v6
}

