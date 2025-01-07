module 0x4fc766d6bf0e998277bec87e7f17e0edfdd966869f313cfaeba6a09007215f0f::sman {
    struct SMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAN>(arg0, 6, b"SMAN", b"Sui Man", b"Yeah im the sui man. Just swimming in the sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4841_6f57cbc868.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

