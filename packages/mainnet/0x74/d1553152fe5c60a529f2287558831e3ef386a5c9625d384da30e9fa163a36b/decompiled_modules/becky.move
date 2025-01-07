module 0x74d1553152fe5c60a529f2287558831e3ef386a5c9625d384da30e9fa163a36b::becky {
    struct BECKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BECKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BECKY>(arg0, 6, b"BECKY", b"SUI MAMA", b"SUI MAMA is a meme coin on the Sui Network, created for fun and speculative trading. It has no intrinsic value, with its price driven by social media trends and hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nqeg_Bo_Qq_Go_UG_3h5_Km_VZT_Lz8sbe_Qa_HB_6_X8g_Mte4_Xpe8f_W_9944b044e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BECKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BECKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

