module 0x7b22539e4b0e02205a0e2a5cadd48f92b40f946f33a7d04aaf21a8d33cb89b06::lgd {
    struct LGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGD>(arg0, 9, b"LGD", b"LibDev", b"Liberal game dev wants to ruin the franchise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e51e906f7d97c6ff0ffcf0dc7c67c7cfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

