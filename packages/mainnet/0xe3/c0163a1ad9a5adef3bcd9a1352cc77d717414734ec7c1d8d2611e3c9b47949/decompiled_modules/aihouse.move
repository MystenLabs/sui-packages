module 0xe3c0163a1ad9a5adef3bcd9a1352cc77d717414734ec7c1d8d2611e3c9b47949::aihouse {
    struct AIHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIHOUSE>(arg0, 6, b"AIHOUSE", b"AiHouse", b"The future of the housing market, build you house use", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086786_1a58372775.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIHOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIHOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

