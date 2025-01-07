module 0x4c4f9fafce74f7adb4c634a40fdc4db2a0832affb16989ecadf300328ce150d6::rhimu {
    struct RHIMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHIMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHIMU>(arg0, 6, b"RHIMU", b"Rhimu Chad", b"The first Rhino on Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_18_56_30_e7dcf124aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHIMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHIMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

