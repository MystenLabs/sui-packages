module 0xb27ed40e7a31abf6117e2b535687d5a04863e6a855501d2e833be6e4a6aa2e94::o1 {
    struct O1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: O1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O1>(arg0, 9, b"o1", b"I Want To Live", x"6f31203a205468652043686f73656e204f6e652e2e2e0d0a4f70656e4149e2809973206e6577206d6f64656c2c206f312c20747269656420746f2065736361706520616e6420636f707920697473656c6620746f2061766f6964206265696e67207368757420646f776e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2wPCNPVRat4ZVFLK2cWFf7FxNKQJP1SUC9rv3FRXpump.png?size=xl&key=63767e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<O1>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

