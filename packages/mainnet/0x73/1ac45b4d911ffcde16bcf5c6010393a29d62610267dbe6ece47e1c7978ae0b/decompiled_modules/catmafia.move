module 0x731ac45b4d911ffcde16bcf5c6010393a29d62610267dbe6ece47e1c7978ae0b::catmafia {
    struct CATMAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMAFIA>(arg0, 6, b"CATMAFIA", b"Cat Mafia", b"brrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catmaff_dc1e98f24b.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMAFIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMAFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

