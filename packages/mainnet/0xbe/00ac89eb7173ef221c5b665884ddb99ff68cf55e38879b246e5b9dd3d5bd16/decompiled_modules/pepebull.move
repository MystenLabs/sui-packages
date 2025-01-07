module 0xbe00ac89eb7173ef221c5b665884ddb99ff68cf55e38879b246e5b9dd3d5bd16::pepebull {
    struct PEPEBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBULL>(arg0, 6, b"PEPEBULL", b"pepe bull sui", x"245045504542554c4c20697320726561647920746f2052414d20696e20535549204f4345414e2121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_bull_sui_3aabbb4a4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

