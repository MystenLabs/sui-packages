module 0x1b8656a9fcbf245b4f3ee1992a8b24d9d0c17c0b0505b91e3f6b37d3a98d3cd8::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"FIGHTFIGHT", b"FIGHT DON BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747753323829.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

