module 0x2f1546e7ef7dc0291217d49dc485c158820531d178018f8cb79d7cfc358c0ab2::ginny {
    struct GINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINNY>(arg0, 6, b"GINNY", b"GINNY MEME", b"#GINNY is the magical memecoin that grants your deepest desires. Rub the Wishing Lamp with GINNY! Let's create some magic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoround_e5cc927f95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

