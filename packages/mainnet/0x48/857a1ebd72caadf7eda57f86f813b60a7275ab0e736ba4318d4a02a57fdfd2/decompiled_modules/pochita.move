module 0x48857a1ebd72caadf7eda57f86f813b60a7275ab0e736ba4318d4a02a57fdfd2::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"POCHITA", b"Pochita", b"POCHITA on $SUI- the rising of a new $DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_f75b36a331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

