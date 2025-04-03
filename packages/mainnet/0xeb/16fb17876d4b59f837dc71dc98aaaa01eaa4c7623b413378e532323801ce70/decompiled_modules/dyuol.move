module 0xeb16fb17876d4b59f837dc71dc98aaaa01eaa4c7623b413378e532323801ce70::dyuol {
    struct DYUOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYUOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYUOL>(arg0, 9, b"DYUOL", b"liuf;l", b"fdhuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5334c13a96bc249fd57d28909d345375blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYUOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYUOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

