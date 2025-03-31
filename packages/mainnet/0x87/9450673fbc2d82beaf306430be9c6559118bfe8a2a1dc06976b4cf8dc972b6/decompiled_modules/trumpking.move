module 0x879450673fbc2d82beaf306430be9c6559118bfe8a2a1dc06976b4cf8dc972b6::trumpking {
    struct TRUMPKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPKING>(arg0, 9, b"TRUMPKING", b"Trumpisking", b"TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/babe8278b731b1cbca3eb650ecf51b8cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPKING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPKING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

