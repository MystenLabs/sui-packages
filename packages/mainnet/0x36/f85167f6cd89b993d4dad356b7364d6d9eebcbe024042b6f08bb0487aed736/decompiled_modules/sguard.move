module 0x36f85167f6cd89b993d4dad356b7364d6d9eebcbe024042b6f08bb0487aed736::sguard {
    struct SGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGUARD>(arg0, 6, b"SGUARD", b"Sui guard Protection", b"Sguard is specifically designed to be a security in the sui network, using innovative and advanced security methods.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20250504_013900_X_3dff7a55de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

