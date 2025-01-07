module 0x90efd61d7ab9982a04240313c4fda1325b0121a7d517f19b7dede123e83c9864::adog {
    struct ADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOG>(arg0, 6, b"ADOG", b"Apple Dog", b"Give me my apple", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9eciqr_58798f0e3e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

