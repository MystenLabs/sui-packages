module 0x220c156dd82637137cc84eb2e7d6c6caf2a07039c80eea8e02f82cbd59e1961::batnic {
    struct BATNIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATNIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATNIC>(arg0, 6, b"BATNIC", b"Batman Sonic", b"Batnic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8552_18b87ad394.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATNIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATNIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

