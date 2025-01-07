module 0xe5ea6c84bc9ccf81a4bb6706f39e8ed52913cb756b87f56e45011bb50a69da95::pelly {
    struct PELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELLY>(arg0, 6, b"PELLY", b"PELLY the baby pelican", b"Pelly is just a baby pelican that loves the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5832_043d9da34a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

