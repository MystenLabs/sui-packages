module 0xf08d942cff5c05d7d09a718bab5493c538e94b1058444b4c30b85c55dc979c44::cerather {
    struct CERATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CERATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CERATHER>(arg0, 9, b"Cerather", b"cerat", b"Cerat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3085a1082a3fea5cc7e4e6820efdb198blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CERATHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CERATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

