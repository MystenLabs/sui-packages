module 0x59b04aa6aba9e6898e142f3e04c43ab293791abc57cbdddaf798db36531b52bf::vance {
    struct VANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANCE>(arg0, 9, b"VANCE", b"Vance Nigga", b"Vance Nigga - Launched on SuiLFG MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigmjt6ryl32kpg5qm4s7hfwv45vynjz5w3d7uwgwtn2esktzzhgea")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

