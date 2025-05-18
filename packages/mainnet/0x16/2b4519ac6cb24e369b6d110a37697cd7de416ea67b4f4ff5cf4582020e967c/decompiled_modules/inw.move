module 0x162b4519ac6cb24e369b6d110a37697cd7de416ea67b4f4ff5cf4582020e967c::inw {
    struct INW has drop {
        dummy_field: bool,
    }

    fun init(arg0: INW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INW>(arg0, 9, b"INW", b"innerwall", b"this is the best coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8015677f763cb7a0908e3cc9fb07aaf3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

