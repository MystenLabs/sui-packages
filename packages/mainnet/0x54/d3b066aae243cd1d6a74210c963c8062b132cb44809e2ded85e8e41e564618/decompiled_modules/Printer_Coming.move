module 0x54d3b066aae243cd1d6a74210c963c8062b132cb44809e2ded85e8e41e564618::Printer_Coming {
    struct PRINTER_COMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINTER_COMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINTER_COMING>(arg0, 9, b"PRINTER", b"Printer Coming", b"printer is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz9OvhHXkAAGyre?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRINTER_COMING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINTER_COMING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

