module 0xa95b991757ef7be40c6f90fdb995d6914772ce0cb7e1fc973564bc3525db6faf::suibee {
    struct SUIBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEE>(arg0, 6, b"SUIBEE", b"SUI BEE", b"Apooh has come out of hibernation and is on the hunt for all the SUIBEE he can find in the Hundred Million Mcap Wood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731259784469.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

