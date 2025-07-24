module 0x6da7553ad490eb72b539bfde3c5c0e003e32abbd34a0fb9568dcd717b0c6ce79::nay {
    struct NAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NAY>(arg0, 6, b"NAY", b"Just say no", b"learn too say no too all things are bad to you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_9176c7eeca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NAY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

