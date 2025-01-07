module 0xdfb12742ec0b8dcb699bc5be0a52df0e22af3cb14e2eb2096b480f24809df92d::suizy {
    struct SUIZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZY>(arg0, 6, b"Suizy", b"Suizy on Sui", b"Sui: The future of blockchain.  Suizy: The unofficial mascot, bringing fun to the future. (No, seriously)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suizy_Sui_89a6ceefb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

