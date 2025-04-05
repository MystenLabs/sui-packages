module 0x740d01703d772778383b7630b9af7c2c24132fe3c6458cc6406663b5ce5d84ca::sptb {
    struct SPTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPTB>(arg0, 9, b"SPTB", b"SapaTinubu", b"SapaTulumbu is a meme coin inspired by the \"joys\" of living in Nigeria under President Tinubu's leadership. This coin is a lighthearted way to poke fun at the struggles many Nigerians face.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b886fd8d193025a14e145b294d14264fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPTB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPTB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

