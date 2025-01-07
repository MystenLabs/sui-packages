module 0xabda068ae7ed3897f2679e59017efa6b2636a7b3f80bde7d60e3e660451887e9::scfsui {
    struct SCFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCFSUI>(arg0, 6, b"SCFSUI", b"SMOKING CHICKEN FISH", b"Smoking chicken fish sui, financial freedom increase bean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B81_F5_DA_5_404_A_4906_A6_E4_6_D2_AD_76_EE_880_500ed7a78c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

