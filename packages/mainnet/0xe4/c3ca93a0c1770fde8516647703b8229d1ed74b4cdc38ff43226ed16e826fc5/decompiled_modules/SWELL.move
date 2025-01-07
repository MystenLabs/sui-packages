module 0xe4c3ca93a0c1770fde8516647703b8229d1ed74b4cdc38ff43226ed16e826fc5::SWELL {
    struct SWELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWELL>(arg0, 9, b"SWELL", b"Swell Governance Token", x"5377656c6c2069732061206e6f6e2d637573746f6469616c207374616b696e672070726f746f636f6c20776974682061206d697373696f6e20746f2064656c697665722074686520776f726c64e28099732062657374206c6971756964207374616b696e6720616e642072657374616b696e6720657870657269656e63652c2073696d706c6966792061636365737320746f20446546692c207768696c65207365637572696e672074686520667574757265206f662053756920616e642072657374616b696e672073657276696365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://etherscan.io/token/images/swellnetwork_32.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SWELL>>(0x2::coin::mint<SWELL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWELL>>(v2);
    }

    // decompiled from Move bytecode v6
}

