module 0xad9a1eb3fe6d00290d2a65ea006b56648e1e8fd33197f72996bbc9a95986a2eb::gogogogo {
    struct GOGOGOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGOGOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGOGOGO>(arg0, 9, b"GOgogogo", b"aoligei", b"wqwdqweqweqeqweq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/62b6ddd95324a55f496d25ab30609207blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGOGOGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOGOGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

