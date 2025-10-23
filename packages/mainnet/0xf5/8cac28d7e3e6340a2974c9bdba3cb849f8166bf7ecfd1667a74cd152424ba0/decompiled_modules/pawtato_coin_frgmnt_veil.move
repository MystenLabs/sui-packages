module 0xf58cac28d7e3e6340a2974c9bdba3cb849f8166bf7ecfd1667a74cd152424ba0::pawtato_coin_frgmnt_veil {
    struct PAWTATO_COIN_FRGMNT_VEIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_VEIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_VEIL>(arg0, 9, b"FRGMT_VEIL", b"Pawtato Fragment of the Veil", b"A thin shimmer runs through this shard, like reality itself bending at the edges. It reveals what lies just beyond mortal perception - the hidden threads behind every event.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-the-veil.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_VEIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_VEIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

