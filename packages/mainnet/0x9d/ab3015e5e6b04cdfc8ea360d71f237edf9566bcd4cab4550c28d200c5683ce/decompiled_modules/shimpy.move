module 0x9dab3015e5e6b04cdfc8ea360d71f237edf9566bcd4cab4550c28d200c5683ce::shimpy {
    struct SHIMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIMPY>(arg0, 6, b"SHIMPY", b"SUISHIMPY", b"Meet $SHIMPY, the savvy, slick, and sharp shrimp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_I_Mb_Rb_U_400x400_f9c060160f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

