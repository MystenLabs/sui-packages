module 0xb76ea99dc7f94610db009f04e9f1885508e4fa9fcc4972cb482a2e44cfebeb76::mel {
    struct MEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEL>(arg0, 6, b"MEL", b"MELNOSE", b"hi i am mel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a697d3a09105110d76d953c7f828f735_acbca8e1a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

