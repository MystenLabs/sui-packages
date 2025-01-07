module 0x922f011f22a5086bbbd89bb5d3614e2bf90fdd6db17a5e0b1179f11f89e756e4::babymove {
    struct BABYMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMOVE>(arg0, 6, b"BABYMOVE", b"BABYMOVEPUMP", b"join now: https://t.me/babymovepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Aq_Iwh_Rzt_400x400_d3dfa9b317.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

