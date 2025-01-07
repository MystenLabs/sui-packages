module 0xb80efe34ed58dc286792623c806c4b70d23ac4e690ac78686cb0b964634cffe9::wagey {
    struct WAGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGEY>(arg0, 6, b"WAGEY", b"Wagey Sui", b"WAGEY is a PvP Wagering platform that allows players to bet on beating high scores, 1v1 matches and more. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wag_f31229e42b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

