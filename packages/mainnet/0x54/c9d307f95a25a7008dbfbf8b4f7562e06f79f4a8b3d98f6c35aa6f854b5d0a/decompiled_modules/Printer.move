module 0x54c9d307f95a25a7008dbfbf8b4f7562e06f79f4a8b3d98f6c35aa6f854b5d0a::Printer {
    struct PRINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINTER>(arg0, 9, b"PRINTER", b"Printer", b"printer is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz9OvhHXkAAGyre?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

