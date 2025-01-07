module 0xe85629f8c99eabda700b3b620fe11597faedb0a18c295d719a395dfb0683f0cb::spuff {
    struct SPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUFF>(arg0, 6, b"sPUFF", b"Smiling Pufferfish", x"5468652063757465737420646563656e7472616c697a6564206669736820696e20746865207365612e20446f6e2774206d616b6520612054472e20446f6e2774206d616b65206120747769747465722e200a0a4b65657020697420646563656e7472616c697a656420616e64206b656570206f6e20736d696c696e670a0a492077696c6c20706179206465782f6164732f626f6f73747320696620796f752063616e2061766f696e6420746865205056502e0a0a4a6f696e20746865205820436f6d6d756e697479207061676520616e64206b65657020736d696c696e67206c696b652074686520666973682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053994_3ba04b3b77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

