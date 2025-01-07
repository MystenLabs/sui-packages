module 0x759f8a32f8484737826974ec541b93cd794678df875cd618dff2b2b7c7748c3::pumbo {
    struct PUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMBO>(arg0, 6, b"PumBo", b"The pumpkin book", b"The first pumpkin book in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728339444589_92f7b86623.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

