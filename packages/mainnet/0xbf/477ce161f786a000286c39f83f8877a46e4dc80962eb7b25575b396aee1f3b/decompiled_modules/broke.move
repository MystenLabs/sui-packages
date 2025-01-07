module 0xbf477ce161f786a000286c39f83f8877a46e4dc80962eb7b25575b396aee1f3b::broke {
    struct BROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKE>(arg0, 6, b"BROKE", b"$BROKE again", b"This is why we can't trust them, they are getting us $BROKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6m_R0_Cj_T3_400x400_1_56c3ab7c19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

