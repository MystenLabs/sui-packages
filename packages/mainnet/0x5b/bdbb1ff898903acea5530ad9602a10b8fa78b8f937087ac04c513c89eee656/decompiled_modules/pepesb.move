module 0x5bbdbb1ff898903acea5530ad9602a10b8fa78b8f937087ac04c513c89eee656::pepesb {
    struct PEPESB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESB>(arg0, 6, b"PEPESB", b"Pepe Sui Beats", x"506570652053756920426561747320f09f8ea7207c20546865206f6666696369616c2072687974686d206f662074686520537569206e6574776f726b207c204d7573696320626f74206f6e2054656c656772616d2c2041492d706f776572656420444a2c20616e64204e4654207374616b696e6720706c6174666f726d2e204272696e67696e672062656174732c20746563682c20616e64207468652053756920636f6d6d756e69747920746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731425489724.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

