module 0x3120a0809c3a7673a68196bfe48735ebbcb1899ebf2d7257db0bdaed68851ec6::trumps {
    struct TRUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPS>(arg0, 6, b"TRUMPS", b"TrmpSui", b"Make Sui in American great again new meme story on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017413_c585e2398b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

