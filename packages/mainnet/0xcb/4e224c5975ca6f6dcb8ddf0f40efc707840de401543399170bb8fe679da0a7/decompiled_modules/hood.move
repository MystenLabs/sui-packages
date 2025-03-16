module 0xcb4e224c5975ca6f6dcb8ddf0f40efc707840de401543399170bb8fe679da0a7::hood {
    struct HOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOD>(arg0, 9, b"HOOD", b"haou", b"holi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/30903e8656f2d996a1fec14116b4f8e0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

