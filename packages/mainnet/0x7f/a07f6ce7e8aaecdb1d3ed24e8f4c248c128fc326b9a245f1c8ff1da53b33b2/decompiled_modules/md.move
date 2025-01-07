module 0x7fa07f6ce7e8aaecdb1d3ed24e8f4c248c128fc326b9a245f1c8ff1da53b33b2::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 6, b"MD", b"C101Z", b"SDE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732067096237.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

