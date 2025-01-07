module 0xc53f5c9d25d59d6adfeac56363f95aa8d480bb0c8704627395e61a872c5fa199::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALT>(arg0, 9, b"ALT", b"ALTSEASON", x"57652061726520616c6c2077616974696e6720666f722068696d2e204c657427732068656c702068696d20676574206879706564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0e6108494e317c6c7747c739e567e4d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

