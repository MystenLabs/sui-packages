module 0x27ddef56ce034f7d46c787ebb8370689409ba5cfea2e031735338650e9363f32::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"STRUMP", b"SUPER TRUMP", b"Super Trump coin, created on SUI by the finest community of Trump supporters. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250125_041404_364_574d7e2566.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

