module 0x6716c20ba08356abfe7fc2764a2a5307b3b94ae29a67259c9ab23806e214add4::dumbo {
    struct DUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBO>(arg0, 6, b"DUMBO", b"Dumbo Octopus", b"Grimpoteuthis is a genus of pelagic cirrate octopods known as the dumbo octopuses.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dumbo_77c338af1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

