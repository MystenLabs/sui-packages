module 0x24f60fb0a12b84533a6a07883ff1621ff63f65efe08a72cb516990898148fdb0::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 6, b"WALLY", b"WALLYS", b"WALLy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732143997523.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

