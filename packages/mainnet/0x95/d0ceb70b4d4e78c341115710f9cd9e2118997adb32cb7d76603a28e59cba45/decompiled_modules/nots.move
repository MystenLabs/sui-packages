module 0x95d0ceb70b4d4e78c341115710f9cd9e2118997adb32cb7d76603a28e59cba45::nots {
    struct NOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTS>(arg0, 6, b"NOTS", b"NOT SUI", x"244e4f54532069732061206d656d6520636f696e20626f726e2066726f6d207472756520537569204f477320e28094206120626f6c6420726573706f6e736520746f207468652077617665206f66207363616d7320666c6f6f64696e6720746865205375692065636f73797374656d2e204675656c6564206279206372656174697669747920616e642068756d6f722c20244e4f5453206272696e6773206d656d6573206261636b20746f206c696665206f6e205375692e204974e2809973206e6f74206a757374206120636f696e20e28094206974e28099732061206d6f76656d656e7420746f204d616b652053756920477265617420416761696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/077f82f1-eb28-4a2a-8055-4d516db99b8f.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

