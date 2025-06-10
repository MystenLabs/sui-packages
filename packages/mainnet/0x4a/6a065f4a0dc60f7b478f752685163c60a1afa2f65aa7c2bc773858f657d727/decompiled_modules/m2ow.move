module 0x4a6a065f4a0dc60f7b478f752685163c60a1afa2f65aa7c2bc773858f657d727::m2ow {
    struct M2OW has drop {
        dummy_field: bool,
    }

    fun init(arg0: M2OW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M2OW>(arg0, 9, b"M2OW", b"2Side Meow", b"Every living thing has two or more sides", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dd3a804b33a29ad9d6dc15120132fa5dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M2OW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M2OW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

