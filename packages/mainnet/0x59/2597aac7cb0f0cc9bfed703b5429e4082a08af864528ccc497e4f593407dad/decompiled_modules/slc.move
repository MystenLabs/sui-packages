module 0x592597aac7cb0f0cc9bfed703b5429e4082a08af864528ccc497e4f593407dad::slc {
    struct SLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLC>(arg0, 6, b"SLC", b"Sui Lovers Clib", b"For Sui lovers, holders, traders, Sui community. Make Sui to the top in 2025! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Aida_5ed34bc576.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

