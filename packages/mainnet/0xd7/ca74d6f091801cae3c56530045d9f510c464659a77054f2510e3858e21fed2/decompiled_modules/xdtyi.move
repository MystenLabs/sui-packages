module 0xd7ca74d6f091801cae3c56530045d9f510c464659a77054f2510e3858e21fed2::xdtyi {
    struct XDTYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDTYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDTYI>(arg0, 9, b"XDTYI", b"dgyuij", b"e6yuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fcd51aeefd16def9acb3506da66fd0d1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XDTYI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDTYI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

