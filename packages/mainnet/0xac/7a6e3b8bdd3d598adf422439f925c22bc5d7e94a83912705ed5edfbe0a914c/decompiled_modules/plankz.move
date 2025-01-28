module 0xac7a6e3b8bdd3d598adf422439f925c22bc5d7e94a83912705ed5edfbe0a914c::plankz {
    struct PLANKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKZ>(arg0, 6, b"PLANKZ", b"Plankz", b"PLANKZ is just the main character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738095221915.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLANKZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

