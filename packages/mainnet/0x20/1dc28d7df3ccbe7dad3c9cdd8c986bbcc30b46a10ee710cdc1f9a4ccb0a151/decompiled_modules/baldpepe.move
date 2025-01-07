module 0x201dc28d7df3ccbe7dad3c9cdd8c986bbcc30b46a10ee710cdc1f9a4ccb0a151::baldpepe {
    struct BALDPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDPEPE>(arg0, 6, b"BALDPEPE", b"Bald Pepe", b"DeFi project Bald Pepe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_9e5bbe7938.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

