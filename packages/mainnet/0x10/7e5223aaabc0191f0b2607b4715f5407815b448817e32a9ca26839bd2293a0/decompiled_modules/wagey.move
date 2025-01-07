module 0x107e5223aaabc0191f0b2607b4715f5407815b448817e32a9ca26839bd2293a0::wagey {
    struct WAGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGEY>(arg0, 6, b"WAGEY", b"Wagey On Sui", b"WAGEY is a PvP Wagering platform that allows players to bet on beating high scores, 1v1 matches and more. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wageymaincoinlogo_3_c861a1e958.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

