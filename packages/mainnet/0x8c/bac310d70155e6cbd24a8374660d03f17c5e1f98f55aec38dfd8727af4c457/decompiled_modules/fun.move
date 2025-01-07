module 0x8cbac310d70155e6cbd24a8374660d03f17c5e1f98f55aec38dfd8727af4c457::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"Fun", b"createfun", b"FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b98994bb1422abcc2ac5e477009c281eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

