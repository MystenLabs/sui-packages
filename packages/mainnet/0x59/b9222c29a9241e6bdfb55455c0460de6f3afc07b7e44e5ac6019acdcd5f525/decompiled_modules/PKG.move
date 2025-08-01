module 0x59b9222c29a9241e6bdfb55455c0460de6f3afc07b7e44e5ac6019acdcd5f525::PKG {
    struct PKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKG>(arg0, 6, b"Package", b"PKG", b"PACKAGEs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/fd1da839-ac98-4a2b-89fe-bb851c2a6ad1")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKG>>(v0, @0x132a99a1da1767ae627ac9cd55dd7dce74e3d7f0ee35a1af18cf4ba6b64e147b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

