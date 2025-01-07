module 0x5abd1c8159abeb8c3ded2a2a787e95d25670c3556c87c94b13d82ddfc040cb8c::soge {
    struct SOGE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SOGE>>(0x2::coin::mint<SOGE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGE>(arg0, 9, b"SOGE", b"SOGE", b"SOGE is DOGE of SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nbope.github.io/foxy/soge256.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

