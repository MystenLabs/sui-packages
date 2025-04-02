module 0xf5b9253fe75c2883ee8d49e79b93f80887738944debf425eb72c9838a3346a2f::i7yfu {
    struct I7YFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: I7YFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I7YFU>(arg0, 9, b"I7YFU", b"kuy6", b"fyulfylu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eb12645e775c9748ef27db80ccd3575eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<I7YFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I7YFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

