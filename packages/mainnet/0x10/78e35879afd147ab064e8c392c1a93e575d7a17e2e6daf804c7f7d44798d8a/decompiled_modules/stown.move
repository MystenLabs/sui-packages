module 0x1078e35879afd147ab064e8c392c1a93e575d7a17e2e6daf804c7f7d44798d8a::stown {
    struct STOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOWN>(arg0, 9, b"STOWN", b"SUI Town", b"Nes Hero of Town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c0177d783b1dc923ce2b4fd9ff628fb8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

