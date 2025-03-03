module 0x5c062a15314409748250ea7ad3e2a1569f09b655d3b3df786c5b2a8df5fc0e5a::pisuieans {
    struct PISUIEANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISUIEANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISUIEANS>(arg0, 9, b"PISUIEANS", b"Pisuieas", b"Dreamy, mystical Pisces fish swimming in the SUI waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/73a25cf0a8b0db9a0a9512b584a8984ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PISUIEANS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISUIEANS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

