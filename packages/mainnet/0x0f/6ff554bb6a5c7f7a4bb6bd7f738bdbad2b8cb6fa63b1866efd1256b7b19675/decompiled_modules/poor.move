module 0xf6ff554bb6a5c7f7a4bb6bd7f738bdbad2b8cb6fa63b1866efd1256b7b19675::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"POOR", b"Poorlax", b"Still holding. Still hoping. Still poor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746222710076.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

