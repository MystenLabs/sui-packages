module 0x8038ca9af1f5561568b61613bccb8e200d2f0f9149335cce59413295a469180::murkz {
    struct MURKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURKZ>(arg0, 6, b"Murkz", b"Murkz Rise", b"Rising from the depths, Murkz are taking over SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Murkz_PFP_c56729103d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

