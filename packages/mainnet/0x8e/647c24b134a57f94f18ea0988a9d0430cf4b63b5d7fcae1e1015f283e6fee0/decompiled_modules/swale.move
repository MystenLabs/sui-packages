module 0x8e647c24b134a57f94f18ea0988a9d0430cf4b63b5d7fcae1e1015f283e6fee0::swale {
    struct SWALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWALE>(arg0, 9, b"SWALE", b"SUI WALE", b"Wale on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/561510ce0c27e7aa74d1ff18fc0cee7bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWALE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

