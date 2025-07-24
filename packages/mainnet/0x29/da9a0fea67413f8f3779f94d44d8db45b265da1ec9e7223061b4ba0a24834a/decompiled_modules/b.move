module 0x29da9a0fea67413f8f3779f94d44d8db45b265da1ec9e7223061b4ba0a24834a::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 9, b"B", b"a", b"c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"d")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B>>(v1);
    }

    // decompiled from Move bytecode v6
}

