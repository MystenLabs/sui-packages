module 0x5349eee3ef8495f82c0e768fb8877b52ac0c41144c6aeaeadd318c9faaec2816::smartai {
    struct SMARTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMARTAI>(arg0, 6, b"SMARTAI", b"Smart AI by SuiAI", b"SmartAI Coin is built on the Sui network. It utilizes intelligent algorithms to offer users highly efficient blockchain data processing services. This enables users to make precise decisions within the crypto world and drives the development of the entire ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20_6f02f4fa9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMARTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

