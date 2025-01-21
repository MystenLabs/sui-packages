module 0x67409a3355bd2aaa7c691ea042c39a2eb23cdbc5c655736cc9b71127448b6670::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 6, b"PINK", b"Pink Panther", b"$PINK is a memecoin on the SUI network based on a recognizable and beloved cartoon character - PINK PANTHER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c0f3ae2067.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

