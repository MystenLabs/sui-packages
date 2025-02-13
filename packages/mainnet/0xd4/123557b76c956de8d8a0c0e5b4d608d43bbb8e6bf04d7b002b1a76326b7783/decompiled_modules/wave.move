module 0xd4123557b76c956de8d8a0c0e5b4d608d43bbb8e6bf04d7b002b1a76326b7783::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"Wave", b"Telegram-based ecosystem for game and D-apps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/wawe_logo_a319f592f1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAVE>>(0x2::coin::mint<WAVE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAVE>>(v2);
    }

    // decompiled from Move bytecode v6
}

