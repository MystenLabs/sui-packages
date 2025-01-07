module 0x56316d19247dfdca1ae28532957eb5481bf1880f084f86be72542fd21703e6b6::sadkekw {
    struct SADKEKW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADKEKW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADKEKW>(arg0, 6, b"SADKEKW", b"SAD KEKW", b"A token for all the high risk degen lovers. Sometimes we lose sometimes we win. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crying_kekw_8ecaf89970.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADKEKW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADKEKW>>(v1);
    }

    // decompiled from Move bytecode v6
}

