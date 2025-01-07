module 0xa9459527a2e02c575054bb2d030ff73b2dd0c312697302978eda92f42d44a92a::kiffy {
    struct KIFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIFFY>(arg0, 6, b"KIFFY", b"Kiffy", b"Dont touch my wet kiffy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1071_f64d5df26f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

