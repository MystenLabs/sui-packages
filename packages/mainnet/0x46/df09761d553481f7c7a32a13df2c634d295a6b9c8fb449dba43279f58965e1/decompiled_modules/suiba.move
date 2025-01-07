module 0x46df09761d553481f7c7a32a13df2c634d295a6b9c8fb449dba43279f58965e1::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 6, b"SUIBA", b"Suiba Inu", b"Sui's First Telegram Trading Bot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rr8q_IDYC_400x400_fb94908733.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

