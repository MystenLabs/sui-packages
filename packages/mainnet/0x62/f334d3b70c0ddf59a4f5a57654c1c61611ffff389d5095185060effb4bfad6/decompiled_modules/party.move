module 0x62f334d3b70c0ddf59a4f5a57654c1c61611ffff389d5095185060effb4bfad6::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 6, b"Party", b"Meme Party", b"Welcome to the best meme party since the last memecoin season, only on the ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_21742afdf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

