module 0xa68f14992ae73d5dab94466a8c269aa5429d7e5e3c6e333753a9bd088191434a::Printer {
    struct PRINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINTER>(arg0, 9, b"PRINTER", b"Printer", b"is coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz9OvhHXkAAGyre?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

