module 0x9c74c83c58383857bbb5dbe23a1905ecddf38dc16cb67760bc989da96d71440a::chonky {
    struct CHONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKY>(arg0, 6, b"CHONKY", b"CHONKY the Frog by Whitaswhit", b"The official Chonky the Frog coin created by Whitaswhitt! Verifiably the only official coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9tc_Ch_Cm93yu_M93_G_Diwn_ERZ_Qr_D7wgy_U21p_HPR_Fmnxpump_094b62d07c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

