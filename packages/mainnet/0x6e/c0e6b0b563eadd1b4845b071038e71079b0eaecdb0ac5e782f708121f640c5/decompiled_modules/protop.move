module 0x6ec0e6b0b563eadd1b4845b071038e71079b0eaecdb0ac5e782f708121f640c5::protop {
    struct PROTOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOP>(arg0, 6, b"PROTOP", b"Proto-Pecuni", b"This is a limited presale of tokens, funding marketing for a Q4 ICO. The ICO will fund Symmetric, the world's first fully post-quantum blockchain. Legacy blockchains employ asymmetric encryption which is susceptible to quantum computers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725989630235_3ea8ebc654222799ba6f0676a41cf117_f33919f098.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROTOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROTOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

