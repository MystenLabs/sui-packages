module 0x4aa8a8ae055e9743737c4922eb9af26c03bb861db1b334d0e4979ab4c0350bc0::pirate {
    struct PIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATE>(arg0, 6, b"PIRATE", b"Sui Pirate", b"$PIRATE. The first pirate on sui. Sail the open ocean together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_75_25ae416f13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

