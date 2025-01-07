module 0x8b3202a3133e152ff07b2e683694a1bbb781563e44bf58030b832eb95ea56233::soscar {
    struct SOSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSCAR>(arg0, 6, b"SOSCAR", b"Sui Oscar", b"Dexscreener Paid.Join Us: https://suioscarshiba.xyz | https://t.me/OscarShiba_Portal | https://x.com/OscarInu_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_13_f62d025ef5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOSCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

