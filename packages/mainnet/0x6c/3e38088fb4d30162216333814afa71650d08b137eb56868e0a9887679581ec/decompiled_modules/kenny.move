module 0x6c3e38088fb4d30162216333814afa71650d08b137eb56868e0a9887679581ec::kenny {
    struct KENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENNY>(arg0, 6, b"KENNY", b"Kenny the Drop Bear", x"4b656e6e79207468652044726f7020426561722069732074686520756c74696d61746520646563656e7472616c697a6564204149206d656d65636f696e206f6e205375692c20616e642068657320636f6d696e6720666f7220796f75210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Esrz3e44m_X5t9_Uk1s_G_Db_WJZ_Jz_Em_V1z_Xcog27zh_Up_BT_3_E_1713db3de4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

