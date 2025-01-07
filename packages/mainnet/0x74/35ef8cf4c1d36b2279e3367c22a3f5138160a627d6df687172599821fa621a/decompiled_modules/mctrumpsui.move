module 0x7435ef8cf4c1d36b2279e3367c22a3f5138160a627d6df687172599821fa621a::mctrumpsui {
    struct MCTRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTRUMPSUI>(arg0, 6, b"McTrumpSui", b"McTrump", b"McTrumpSui is now on Sui and MovePump!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumpfrie_be75161289.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

