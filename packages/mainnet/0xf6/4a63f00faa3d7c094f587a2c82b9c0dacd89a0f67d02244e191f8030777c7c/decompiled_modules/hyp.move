module 0xf64a63f00faa3d7c094f587a2c82b9c0dacd89a0f67d02244e191f8030777c7c::hyp {
    struct HYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYP>(arg0, 9, b"HYP", b"Hypnos", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fd9c42e54c139b9af7091445680d8dceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

