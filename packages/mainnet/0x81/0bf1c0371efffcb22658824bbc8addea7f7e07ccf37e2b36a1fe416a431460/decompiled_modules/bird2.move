module 0x810bf1c0371efffcb22658824bbc8addea7f7e07ccf37e2b36a1fe416a431460::bird2 {
    struct BIRD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD2>(arg0, 6, b"BIRD2", b"bird2", b"bird 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_e_60ed1b1763.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRD2>>(v1);
    }

    // decompiled from Move bytecode v6
}

