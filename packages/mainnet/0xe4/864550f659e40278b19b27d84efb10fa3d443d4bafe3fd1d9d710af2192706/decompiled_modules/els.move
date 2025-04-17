module 0xe4864550f659e40278b19b27d84efb10fa3d443d4bafe3fd1d9d710af2192706::els {
    struct ELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELS>(arg0, 9, b"ELS", b"ELYS", b"1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8e6e9af669fa076b36a46561ab83fc21blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

