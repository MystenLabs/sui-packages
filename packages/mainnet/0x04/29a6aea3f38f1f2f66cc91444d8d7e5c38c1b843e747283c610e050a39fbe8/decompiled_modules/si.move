module 0x429a6aea3f38f1f2f66cc91444d8d7e5c38c1b843e747283c610e050a39fbe8::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SI>(arg0, 9, b"SI", b"suiii", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/abb19aa762b4cf4e6faaaaf9a40844a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

