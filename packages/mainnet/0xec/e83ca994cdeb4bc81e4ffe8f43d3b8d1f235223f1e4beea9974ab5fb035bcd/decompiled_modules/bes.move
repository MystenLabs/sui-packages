module 0xece83ca994cdeb4bc81e4ffe8f43d3b8d1f235223f1e4beea9974ab5fb035bcd::bes {
    struct BES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BES>(arg0, 9, b"BES", b"BTCETHSOL", x"42455320e280932074686520756c74696d617465207472696e697479206f662063727970746f2e20426974636f696e3a20746865204661746865722c20457468657265756d3a2074686520486f6c79205370697269742c20536f6c616e613a2074686520536f6e2e20506f7765722c20696e6e6f766174696f6e2c207370656564e28094756e6974656420696e206f6e6520746f6b656e2e2042656c69657665206f72206265206c65667420626568696e642e204a6f696e207468652062656c696576657273206f6620746865206e6577206469676974616c206f726465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b197d5c-152a-4be9-88f6-14fed2772383.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BES>>(v1);
    }

    // decompiled from Move bytecode v6
}

