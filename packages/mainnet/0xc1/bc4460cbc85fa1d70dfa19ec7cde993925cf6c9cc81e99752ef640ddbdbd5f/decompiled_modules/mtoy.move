module 0xc1bc4460cbc85fa1d70dfa19ec7cde993925cf6c9cc81e99752ef640ddbdbd5f::mtoy {
    struct MTOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTOY>(arg0, 6, b"MTOY", b"MEME TOY", b"buy to pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scf_d1d6790bd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

