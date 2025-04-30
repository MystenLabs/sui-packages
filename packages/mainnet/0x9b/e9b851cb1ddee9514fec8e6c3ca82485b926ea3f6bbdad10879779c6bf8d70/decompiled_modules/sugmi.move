module 0x9be9b851cb1ddee9514fec8e6c3ca82485b926ea3f6bbdad10879779c6bf8d70::sugmi {
    struct SUGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGMI>(arg0, 9, b"Sugmi", b"wagmi", b"suckit  suckit  suckit  suckit ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/513dea854a349a93183fd2f706796ee5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

