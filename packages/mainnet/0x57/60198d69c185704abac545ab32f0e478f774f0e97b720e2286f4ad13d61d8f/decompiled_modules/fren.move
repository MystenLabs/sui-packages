module 0x5760198d69c185704abac545ab32f0e478f774f0e97b720e2286f4ad13d61d8f::fren {
    struct FREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREN>(arg0, 6, b"FREN", b"SuiAlienFrens", b"Aliens Invading Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FI_15_JZ_5_XEAQ_3_Ai_B_4daa145360.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

