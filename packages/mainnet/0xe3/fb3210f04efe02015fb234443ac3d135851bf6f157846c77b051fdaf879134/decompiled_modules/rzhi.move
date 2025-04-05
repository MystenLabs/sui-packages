module 0xe3fb3210f04efe02015fb234443ac3d135851bf6f157846c77b051fdaf879134::rzhi {
    struct RZHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RZHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZHI>(arg0, 9, b"RZHI", b"Rychyi", b"Alex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/527f937879eb6af48e1df04fc0a0d2edblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RZHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

