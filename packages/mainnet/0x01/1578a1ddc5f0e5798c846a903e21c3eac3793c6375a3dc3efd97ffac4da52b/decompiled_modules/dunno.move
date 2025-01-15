module 0x11578a1ddc5f0e5798c846a903e21c3eac3793c6375a3dc3efd97ffac4da52b::dunno {
    struct DUNNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUNNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUNNO>(arg0, 6, b"DUNNO", b"DUNNO ON SUI", b"$DUNNO bringing memes back to their roots !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DUNNO_fbe12c7d49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUNNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

