module 0x8958faced31e414305b86009d047894de990df5d58d9aecb68a6cf7db0001cec::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"a by SuiAI", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/telegram_cloud_photo_size_1_5150363514387410198_y_ed8be5585d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

