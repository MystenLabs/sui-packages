module 0x94a192954cea8940a0a87931db7aa73175e514881c2ca71685157aa79bc2890a::taguro {
    struct TAGURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAGURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAGURO>(arg0, 6, b"TAGURO", b"Taguro", b"Dragon Ball Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731330403278.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAGURO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAGURO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

