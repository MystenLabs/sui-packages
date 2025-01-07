module 0x375bd743f93aabed18a5dc1fec7250217160283b992c9e6ed1ca2579e5c4bb06::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"Homer", b"SuiHomer", b"Homer launch on Sui Chain that we launch movepump now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4028_825f5dddd0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

