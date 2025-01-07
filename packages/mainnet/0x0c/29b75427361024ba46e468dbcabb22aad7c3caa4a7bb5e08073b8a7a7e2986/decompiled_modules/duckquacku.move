module 0xc29b75427361024ba46e468dbcabb22aad7c3caa4a7bb5e08073b8a7a7e2986::duckquacku {
    struct DUCKQUACKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKQUACKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKQUACKU>(arg0, 6, b"DUCKQUACKU", b"DUCK SUI", b"QUACKU QUACKUQUACKU QUACKUQUACKU QUACKUQUACKU QUACKUQUACKU QUACKU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_19_5bb5b414d5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKQUACKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKQUACKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

