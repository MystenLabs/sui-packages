module 0x46ed3e7ea683e83caaa7e1a50d7ce8afe8d8fe8b5a621cb26761963ac308c03e::dyhfuol {
    struct DYHFUOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYHFUOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYHFUOL>(arg0, 9, b"DYHFUOL", b"fyukk", b"YJKL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1eccdb17e8b79fd1e31ef109720a3148blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYHFUOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYHFUOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

