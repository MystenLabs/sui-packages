module 0xa15f5e3e1ee0dc81292ceef74a787e881575e64aa94fdeafe6f28f7a91266bc9::crog {
    struct CROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROG>(arg0, 6, b"CROG", b"Crab dog", b"A crab looking like a dog,a dog looking like a crab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_6dc5b064ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

