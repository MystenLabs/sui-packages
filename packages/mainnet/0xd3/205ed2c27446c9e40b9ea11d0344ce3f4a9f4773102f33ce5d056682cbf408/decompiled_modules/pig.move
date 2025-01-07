module 0xd3205ed2c27446c9e40b9ea11d0344ce3f4a9f4773102f33ce5d056682cbf408::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIG", b"SPIG", b"The most telegram-native memecoin | Head to Telegram to count your friends, see your total, and redeem your rewards! #SPIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PIGER_TA_7izh_2_Xjwhfyt_Dn_GB_01b884e6b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

