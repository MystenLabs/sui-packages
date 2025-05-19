module 0x4a3113c504908fca5d63b7fedf468a575195a68e0a1b855e9280e35819d868e4::COLOR {
    struct COLOR has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<COLOR>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0xd35f8325f49901d46c6f4b17e90a4ac5aa2c5c011cb861b0524f5cd22ece0d25 || 0x2::tx_context::sender(arg2) == @0xd35f8325f49901d46c6f4b17e90a4ac5aa2c5c011cb861b0524f5cd22ece0d25, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<COLOR>>(arg0, arg1);
    }

    fun init(arg0: COLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLOR>(arg0, 9, b"COLOR", b"Sui Color", b"Color of money on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreibc64dqadfyxoajhmlc2ym2ptu43pvtqdxukus565da3ky2d53n5y")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COLOR>>(0x2::coin::mint<COLOR>(&mut v2, 1000000000000000000, arg1), @0xd35f8325f49901d46c6f4b17e90a4ac5aa2c5c011cb861b0524f5cd22ece0d25);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COLOR>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

