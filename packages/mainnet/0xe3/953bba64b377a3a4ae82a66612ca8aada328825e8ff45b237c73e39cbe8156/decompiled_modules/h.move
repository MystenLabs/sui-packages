module 0xe3953bba64b377a3a4ae82a66612ca8aada328825e8ff45b237c73e39cbe8156::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 9, b"H", b"huzi", b"no", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/09b8b46e437750f92d156a5b853ee4ceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

