module 0x3376cfeb371d2ec0cf1151296b7179d0e067cbfda502bbe56cea28c3a7019b5c::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAP>(arg0, 6, b"WAP", b"Wap Coin", x"57415020436f696e206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e20696e737069726564206279204361726469204227732069636f6e6963206361742e20456d62726163696e672074686520737069726974206f662020696e636c7573697669747920616e642066756e2c20245741502061696d7320746f206272696e6720612073706c617368206f66206578636974656d656e7420746f207468652063727970746f63757272656e63792073706163652e0a0a4c65742773206d616b65205765616c746820416e642050726f737065726974792024574150", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000174007_05ca1b43b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

