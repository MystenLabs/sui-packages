module 0x7a9fd45e512cb0e41110267c73faf9c0f62f4b5cadf5aadc65f9af35c950dd3b::sbaer {
    struct SBAER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAER>(arg0, 9, b"SBAER", b"Subear", b"Cutest bear on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/643813a799d3d1d1d8604ab250d93156blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBAER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

