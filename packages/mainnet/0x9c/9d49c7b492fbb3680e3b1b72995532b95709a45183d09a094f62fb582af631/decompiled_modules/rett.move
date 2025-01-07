module 0x9c9d49c7b492fbb3680e3b1b72995532b95709a45183d09a094f62fb582af631::rett {
    struct RETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETT>(arg0, 6, b"RETT", b"Rett the Robot", b"Rett was made for one mission - to make Sui the number one ecosystem across the galaxy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xaxa_248845ee3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

