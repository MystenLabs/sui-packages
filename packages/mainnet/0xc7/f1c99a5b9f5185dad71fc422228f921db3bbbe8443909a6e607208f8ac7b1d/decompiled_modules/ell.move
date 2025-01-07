module 0xc7f1c99a5b9f5185dad71fc422228f921db3bbbe8443909a6e607208f8ac7b1d::ell {
    struct ELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELL>(arg0, 9, b"ELL", b"she", b"woman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/474901f50762f6bc7b9c92077c07db2cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

