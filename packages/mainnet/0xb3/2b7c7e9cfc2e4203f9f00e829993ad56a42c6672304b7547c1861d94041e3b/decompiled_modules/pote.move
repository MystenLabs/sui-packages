module 0xb32b7c7e9cfc2e4203f9f00e829993ad56a42c6672304b7547c1861d94041e3b::pote {
    struct POTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTE>(arg0, 9, b"POTE", b"poteto", b"POTETO COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/919acb2940c9ee435f5b4609c81c3bf5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

