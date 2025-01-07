module 0xb53fcfa82b9ba3c8067d115c9753b31dd976820ea0545af218530c72fb55c0d::boltsui {
    struct BOLTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLTSUI>(arg0, 6, b"BOLTSUI", b"Official Bolt On Sui", b"Imagine a world where loyalty isn't just a trait but a currency.Join us: https://t.me/BoltSui_Portal | Website: https://www.boltonsui.fun | X: https://x.com/BOLT_SuiCTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1111_821d6d720b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

