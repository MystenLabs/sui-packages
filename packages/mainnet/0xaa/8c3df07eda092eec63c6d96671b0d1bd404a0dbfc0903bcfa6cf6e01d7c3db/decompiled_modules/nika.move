module 0xaa8c3df07eda092eec63c6d96671b0d1bd404a0dbfc0903bcfa6cf6e01d7c3db::nika {
    struct NIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKA>(arg0, 6, b"NIKA", b"SUN GOD NIKA", x"5765204172650a546865205374726f6e676573740a4d454d452050726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suigod_75e95fa4bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

