module 0x79e687fabacb1ca90061aee65a3cd83363f3a375dd9f6acfa847ace16291af56::avt {
    struct AVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVT>(arg0, 6, b"Avt", b"Kora", b"The water nation avatar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001581_9f93fdc5ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

