module 0x5e737b2ddbd0008049cae319a28bd4925f09e10116fbf35c1fe8eb366ecc9b20::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"SaphirAI", b"Saphira, the autonomous AI of the Sui blockchain, seamlessly interacts with third-party tokens, optimizing every transaction for maximum profit. Self-reliant and powered by advanced algorithms, she analyzes market trends, executes trades, and adapts ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733280099273.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

