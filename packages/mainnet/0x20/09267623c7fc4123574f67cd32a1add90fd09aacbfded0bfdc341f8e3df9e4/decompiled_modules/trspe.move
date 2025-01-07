module 0x2009267623c7fc4123574f67cd32a1add90fd09aacbfded0bfdc341f8e3df9e4::trspe {
    struct TRSPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSPE>(arg0, 9, b"TRSPE", b"TRESST PePe On Sui", b"TRUSPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/728ebe07e5032c8022a6118ac01a118fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRSPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

