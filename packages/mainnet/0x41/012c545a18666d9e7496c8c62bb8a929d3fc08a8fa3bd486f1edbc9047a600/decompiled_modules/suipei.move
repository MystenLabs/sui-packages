module 0x41012c545a18666d9e7496c8c62bb8a929d3fc08a8fa3bd486f1edbc9047a600::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"Suipei", b"Sui Peipei", b"The cat warrior on Sui  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_suipei_51c692b226.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

