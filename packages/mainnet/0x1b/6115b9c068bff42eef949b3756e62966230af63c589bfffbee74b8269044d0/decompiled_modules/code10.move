module 0x1b6115b9c068bff42eef949b3756e62966230af63c589bfffbee74b8269044d0::code10 {
    struct CODE10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODE10>(arg0, 6, b"Code10", b"HERO CODE 10", b"Hero phone number : 10", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Yzn_K8_XYAA_Oua_5006a64b30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODE10>>(v1);
    }

    // decompiled from Move bytecode v6
}

