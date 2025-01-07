module 0x54c676a0e4cb246c9816709ec76b222246871afc308bc7f020d58e2f402f1d0a::suiomochi {
    struct SUIOMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOMOCHI>(arg0, 6, b"SUIOMOCHI", b"OMOCHI", x"5468697320697320737569206e6574776f726b73206669727374204f4d4f4348490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111111111111_40017033a3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOMOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOMOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

