module 0xf3125c81ae7b9252d09f752bc62d4c3a3526e8810c4aafbcaf42b8a59d385662::babymove {
    struct BABYMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMOVE>(arg0, 6, b"BABYMOVE", b"BABYMOVEPUMP", b"Join now: https://t.me/babymovepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Aq_Iwh_Rzt_400x400_461bb2874a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

