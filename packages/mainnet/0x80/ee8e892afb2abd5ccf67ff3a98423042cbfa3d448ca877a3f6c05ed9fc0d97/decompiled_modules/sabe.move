module 0x80ee8e892afb2abd5ccf67ff3a98423042cbfa3d448ca877a3f6c05ed9fc0d97::sabe {
    struct SABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABE>(arg0, 6, b"SABE", b"Sui Abe", x"53756920416d657269636173204f6666696369616c20426972640a4d656d6520666f722065766572796f6e652c206c6574277320627265616b2064657873637265656e6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_Go_Rpt_Nx_400x400_faaf91b34e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

