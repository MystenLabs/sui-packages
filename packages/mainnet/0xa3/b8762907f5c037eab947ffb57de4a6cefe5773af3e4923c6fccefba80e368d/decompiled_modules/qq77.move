module 0xa3b8762907f5c037eab947ffb57de4a6cefe5773af3e4923c6fccefba80e368d::qq77 {
    struct QQ77 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQ77, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ77>(arg0, 9, b"QQ77", b"QQQ7777", b"Let's go ahead and defeat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a28cf8dd6e3b3c3e765ecaa2f58b3f8ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQ77>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ77>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

