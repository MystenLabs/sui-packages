module 0xe804b752672230e493da58908de07f619ae51280363b8b84cbfe56036f064e8b::gumma {
    struct GUMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMMA>(arg0, 6, b"GUMMA", b"GUMMASUI", b"$GUMMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme76_Zn9kih_Js5p_Ju_U6_V7sa_T_Vi2e_Y1_S_Ud_H9o_Hh6_Zcexmfx_0568699163.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

