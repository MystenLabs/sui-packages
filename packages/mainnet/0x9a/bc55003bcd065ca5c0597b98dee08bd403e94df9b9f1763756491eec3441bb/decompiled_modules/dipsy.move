module 0x9abc55003bcd065ca5c0597b98dee08bd403e94df9b9f1763756491eec3441bb::dipsy {
    struct DIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DIPSY>(arg0, 6, b"DIPSY", b"DIPSY", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $DIPSY + DIPSY ON SUI https://t.co/7c3l4upoT1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dipsy-xblpv2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIPSY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIPSY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

