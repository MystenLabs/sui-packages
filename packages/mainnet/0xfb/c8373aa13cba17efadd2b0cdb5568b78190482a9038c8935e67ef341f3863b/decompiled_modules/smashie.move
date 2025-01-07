module 0xfbc8373aa13cba17efadd2b0cdb5568b78190482a9038c8935e67ef341f3863b::smashie {
    struct SMASHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASHIE>(arg0, 6, b"SMASHIE", b"Smashie On sui", b"memecoin on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016044_aa3a82532a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

