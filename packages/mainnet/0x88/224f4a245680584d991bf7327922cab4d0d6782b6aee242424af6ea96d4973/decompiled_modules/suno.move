module 0x88224f4a245680584d991bf7327922cab4d0d6782b6aee242424af6ea96d4973::suno {
    struct SUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNO>(arg0, 6, b"SUNO", b"Sungshoon Baby", b"Sungshoon Baby ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_01_3853e6220c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

