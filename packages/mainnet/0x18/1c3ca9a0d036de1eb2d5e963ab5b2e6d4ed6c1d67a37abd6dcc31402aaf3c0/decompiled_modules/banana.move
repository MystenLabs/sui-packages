module 0x181c3ca9a0d036de1eb2d5e963ab5b2e6d4ed6c1d67a37abd6dcc31402aaf3c0::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"BANANA", b"banana token", b"banana is king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a4def99fc51ae9c6b7cd36d621b1923blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

