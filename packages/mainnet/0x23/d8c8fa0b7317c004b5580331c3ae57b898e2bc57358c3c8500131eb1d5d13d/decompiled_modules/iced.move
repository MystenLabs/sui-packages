module 0x23d8c8fa0b7317c004b5580331c3ae57b898e2bc57358c3c8500131eb1d5d13d::iced {
    struct ICED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICED>(arg0, 6, b"ICED", b"Iced The Penguin", b"ICED is that penguin, always by your side, bringing luck, fun, and just the right amount of degen energy to every adventure on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidkxxregejaje622cdq45rwrtl7dccih7c7iegazzq5xsuautttga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

