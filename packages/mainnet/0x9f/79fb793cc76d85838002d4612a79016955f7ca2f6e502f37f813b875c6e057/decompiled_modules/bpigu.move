module 0x9f79fb793cc76d85838002d4612a79016955f7ca2f6e502f37f813b875c6e057::bpigu {
    struct BPIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPIGU>(arg0, 6, b"BPIGU", b"BabyPIGU", b"Navigating PIGU's world on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zmt_Wu5a_QA_Adk_Dl_ad01671d43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPIGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

