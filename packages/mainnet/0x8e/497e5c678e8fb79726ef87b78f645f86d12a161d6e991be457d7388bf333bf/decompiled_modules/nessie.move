module 0x8e497e5c678e8fb79726ef87b78f645f86d12a161d6e991be457d7388bf333bf::nessie {
    struct NESSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NESSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NESSIE>(arg0, 6, b"NESSIE", b"Nessie", b"The Loneli Ness Monster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NESSIE_86e12de089.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NESSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NESSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

