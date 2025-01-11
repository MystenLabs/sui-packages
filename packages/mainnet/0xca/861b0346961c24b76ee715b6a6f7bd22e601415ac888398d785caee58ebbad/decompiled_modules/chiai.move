module 0xca861b0346961c24b76ee715b6a6f7bd22e601415ac888398d785caee58ebbad::chiai {
    struct CHIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHIAI>(arg0, 6, b"CHIAI", b"ChihuahuaAi by SuiAI", b"the first Chihuahua AI on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/lilly_profilbild_e7fa2fa66d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

