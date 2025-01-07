module 0xc6027d0d595c708c46ec647d6b63d9abc99d7c557bffea8f5b8459e39df52cb4::brody {
    struct BRODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRODY>(arg0, 9, b"Brody", b"W Shiba", b"A white shiba that makes you happy everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7448c2e5279d69a579978dcf8c23f0aeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRODY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRODY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

