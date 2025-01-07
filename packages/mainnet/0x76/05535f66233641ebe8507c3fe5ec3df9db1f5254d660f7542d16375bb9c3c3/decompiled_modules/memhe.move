module 0x7605535f66233641ebe8507c3fe5ec3df9db1f5254d660f7542d16375bb9c3c3::memhe {
    struct MEMHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMHE>(arg0, 6, b"MEMHE", b"MEMEHE", b"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6GV0A2AGAFB6JPVDCVHSKD/01JB91G83TB9XXTEND9ZFRBSJ4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMHE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

