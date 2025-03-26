module 0x9820b9cb4c03bf8b5cc9a42ddfde73651e47a08fd0b145ec0a57391846e2580c::simo {
    struct SIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMO>(arg0, 6, b"SIMO", b"Simo", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://play-lh.googleusercontent.com/xG5CttFjLM3JYVD_nxWvnnNrvaBZqQyB5HMkL3KUHt9ujt1ILNyJ_6yh2C4iqtjMWSQ=w240-h480-rw"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIMO>>(v2);
    }

    // decompiled from Move bytecode v6
}

