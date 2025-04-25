module 0x61b94e251a276d962a9478015534bb5b1480e50a66ce84a9b35bf991b8234256::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 9, b"FAUCET", b"SUI Faucet", x"4561726e20627920686f6c64696e672e2052756e206279206e6f206f6e652e204472697070696e6720666f72657665722e0a0a2446415543455420697320746865206669727374206175746f6e6f6d6f7573206472697020746f6b656e206f6e205355492e205468657265e2809973206e6f207465616d2c206e6f20726f61646d61702c206e6f2070726f6d6973657320e28094206a7573742070757265207061737369766520666c6f772e0a0a486f6c6420244641554345542e204765742072657761726465642e2054686174e28099732069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_680b1392b606e1.72533850.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
    }

    // decompiled from Move bytecode v6
}

