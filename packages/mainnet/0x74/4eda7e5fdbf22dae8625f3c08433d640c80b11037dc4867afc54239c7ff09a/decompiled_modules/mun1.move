module 0x744eda7e5fdbf22dae8625f3c08433d640c80b11037dc4867afc54239c7ff09a::mun1 {
    struct MUN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN1>(arg0, 9, b"MUN1", b"Mun01", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/ea1cdf4fe3b51786f68b9b2c66010134blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

