module 0xa16366a54e975fd7e1ea54962a0bed0985e57721aff90ae7ebf9e25bb8483e5c::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 6, b"SW", b"SUIWAVE", b"SUIWAVE the first wave on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731055213668.15")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

