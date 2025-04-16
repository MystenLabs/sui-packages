module 0xc7fd8b977c60f9bead05882c5a330b4ed1768a1cd42b32a83899f840ef4163a::lzi {
    struct LZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZI>(arg0, 9, b"Lzi", b"lozi", b"best ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4ca521b390aa3db84351f8a06e4757a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

