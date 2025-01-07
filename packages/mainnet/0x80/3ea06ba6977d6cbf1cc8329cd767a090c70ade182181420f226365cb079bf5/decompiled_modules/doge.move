module 0x803ea06ba6977d6cbf1cc8329cd767a090c70ade182181420f226365cb079bf5::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"DOGE COIN on SUI", x"f09f90b6444f474520434f494ef09f90b6206f6e20f09faaac535549f09faaac0a0af09f9a804a55535420484f444cf09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731570525704.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

