module 0x6d345d660adff0b5b019d8b2db24404ef9eafb2bc6b80b151ca2f09829e122fa::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"The dev is a fish", x"49742773206a7573742061206675636b696e6720666973682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc8os_WJ_3_Cvu_G_Vd8_M4_U3p_Tfuzn_W5_Hp_Hzk_KLXZV_Ybsmsib_D_1e87fe5627.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

