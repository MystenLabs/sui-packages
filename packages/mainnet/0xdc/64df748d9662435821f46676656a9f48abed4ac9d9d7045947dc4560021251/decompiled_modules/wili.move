module 0xdc64df748d9662435821f46676656a9f48abed4ac9d9d7045947dc4560021251::wili {
    struct WILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILI>(arg0, 6, b"Wili", b"Wiliam The Alligator", b"Wiliam the alligator living his best life on Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wilsonprofil_2d402e0e49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

