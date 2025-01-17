module 0x84b7584e9ec29469e7f1c2ab68024a3e4319062b7d1976c1fad4d0021cd54c29::sptai {
    struct SPTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPTAI>(arg0, 6, b"SPTAI", b"SPOT AI", b"SPOT AI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250117_220541_e08287c908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

