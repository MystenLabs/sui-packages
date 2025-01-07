module 0x7d56aaf373bc52a78704d2abacf5e5b4f827d073d636a9c1f0124f783e6539aa::chilldog {
    struct CHILLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLDOG>(arg0, 6, b"Chilldog", b"ChillDog on Sui", x"4d65657420244348494c4c444f47206f6e205355492c2074686520746f6b656e2074686174e280997320616c6c2061626f757420676f6f642076696265732c20636f6d6d756e6974792c20616e6420686176696e672061206368696c6c2074696d6520696e207468652063727970746f20776f726c642e20496e73706972656420627920746865206c6169642d6261636b20656e65726779206f662065766572796f6e65e2809973206661766f7269746520667572727920667269656e642c20f09f8cadf09f8cadf09f8cad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734660099045.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

