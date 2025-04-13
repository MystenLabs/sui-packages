module 0xa6be2c23254de819ae85cad16e38c2d4f2bb0d25f52345489fb44fd9b63c14c5::johnathan {
    struct JOHNATHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHNATHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNATHAN>(arg0, 9, b"JOHNATHAN", b"JOHNATHAN THE TORTOISE", b"NICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f09df038df35457c2c085eff083d934fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNATHAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNATHAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

