module 0xf2a8ff9e290575e0a129428784b0a1f70170eb9f3c6bbf5e1f2828e735193b88::suilk {
    struct SUILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILK>(arg0, 6, b"SUILK", b"Suilk Road", b"Rebuilt Fully On Chain On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6392600_A_C867_48_A1_9_FC_7_D1_D8672_AD_601_255255d860.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

