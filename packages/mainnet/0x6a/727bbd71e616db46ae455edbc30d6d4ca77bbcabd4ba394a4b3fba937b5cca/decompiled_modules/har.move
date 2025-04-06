module 0x6a727bbd71e616db46ae455edbc30d6d4ca77bbcabd4ba394a4b3fba937b5cca::har {
    struct HAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAR>(arg0, 9, b"HAR", b"Harria", b"xxxcsaad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f73122ab5d814ff5ab50026d74884987blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

