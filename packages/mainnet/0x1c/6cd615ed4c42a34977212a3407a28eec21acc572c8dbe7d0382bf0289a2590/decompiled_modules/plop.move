module 0x1c6cd615ed4c42a34977212a3407a28eec21acc572c8dbe7d0382bf0289a2590::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"PLOP", b"SUI Plop", b"Official emoji of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFP_e019216c48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

