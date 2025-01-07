module 0xf39815d2a4f913520a70fd5f4f1b55b7568f2e60ec6d0d1e1c8f14095b27a51a::tut {
    struct TUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUT>(arg0, 6, b"TUT", b"Pututu", b"i'm tut, u're tut, we're tut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pututu_removebg_preview_baff79fb8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

