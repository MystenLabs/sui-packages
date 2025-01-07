module 0x6895973f9980dffd5f42f8449dcec309f8dbcc1236e7aba0a9674b9194ddd6d3::suineiro {
    struct SUINEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEIRO>(arg0, 6, b"SUINEIRO", b"NEIROSUI", b"the biggest eth coin, came to sui buy and hold, let's go to the moon together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Neiro_Doge_Sister_g_ID_7_4a761fccb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

