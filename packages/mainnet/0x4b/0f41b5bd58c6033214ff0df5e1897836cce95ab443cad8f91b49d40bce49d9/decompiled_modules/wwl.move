module 0x4b0f41b5bd58c6033214ff0df5e1897836cce95ab443cad8f91b49d40bce49d9::wwl {
    struct WWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWL>(arg0, 9, b"WWL", b"Wolkino", b"Wolkino proof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c2eb86754a072ea66d2bc7e0d9b6126fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

