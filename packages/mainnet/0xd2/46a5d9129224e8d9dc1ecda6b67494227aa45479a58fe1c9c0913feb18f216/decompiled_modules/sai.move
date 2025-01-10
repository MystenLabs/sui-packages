module 0xd246a5d9129224e8d9dc1ecda6b67494227aa45479a58fe1c9c0913feb18f216::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Smart AI by SuiAI", b"SmartAI Coin is built on the Sui network. It utilizes intelligent algorithms to offer users highly efficient blockchain data processing services. This enables users to make precise decisions within the crypto world and drives the development of the entire ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6_b1eb111179.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

