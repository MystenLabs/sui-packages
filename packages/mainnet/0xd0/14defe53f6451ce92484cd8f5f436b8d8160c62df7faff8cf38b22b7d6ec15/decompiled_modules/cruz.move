module 0xd014defe53f6451ce92484cd8f5f436b8d8160c62df7faff8cf38b22b7d6ec15::cruz {
    struct CRUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUZ>(arg0, 6, b"CRUZ", b"CRUZ THE UGLY CAT", b"CRUZ is coming !! MEET $CRUZ, the ugly cat who's about to change the sui memes world because \"ugly is the new cute\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_pp_719f494257.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

