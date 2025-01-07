module 0xa0c3a59e6dabd159fdcd750d05a6077804743417db62fb10d3ce58ae9c5e3bdb::memon {
    struct MEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMON>(arg0, 6, b"MEMON", b"MeMon", b"The Kindest Demons on the internet. All you need is two things: your meme and your demons. PLEASE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rcw_U9_QAC_400x400_d0023bf9c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

