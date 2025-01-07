module 0x20fcae4d08e38ed1b0ddd8184138c7100831ed523dead4df43307757cea7de7a::token1 {
    struct TOKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN1>(arg0, 9, b"TOKEN1", b"token Demo 1", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bd4d1420352dbf8e7375fe443f8872dbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

