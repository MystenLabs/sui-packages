module 0x9dd6551cc9872e43cdca0f96d198ce59abe338326f31701982100ec2caf2e3b7::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"SPARK", b"Spark Ai by SuiAI", b"The $SPARK token is an innovative cryptocurrency designed to power the next generation of AI interactions on the Sui blockchain. It is managed by SparkAI, a cutting-edge AI agent that operates on Twitter, delivering real-time insights and intelligent content across the platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_16_051355_removebg_preview_c9a29b77bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

