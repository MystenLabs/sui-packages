module 0x78824f82fbb09f77f84d1712b86f27dd7c7e374beab2407e86580350dac8ac8e::jm {
    struct JM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JM>(arg0, 9, b"JM", b"JMaster ", b"JMaster is a governance token on the sui blochain which is promoted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5cae977-2c4b-4ff2-95b2-c0bca1e16c76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JM>>(v1);
    }

    // decompiled from Move bytecode v6
}

