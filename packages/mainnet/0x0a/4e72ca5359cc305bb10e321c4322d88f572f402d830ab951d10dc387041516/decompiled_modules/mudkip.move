module 0xa4e72ca5359cc305bb10e321c4322d88f572f402d830ab951d10dc387041516::mudkip {
    struct MUDKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIP>(arg0, 6, b"MUDKIP", b"MudkipOnSui", b"Here we go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962249128.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

