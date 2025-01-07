module 0xba5642d8f25ef778298397c77922a2d97372c549ba56377db077f996ca69e410::surge {
    struct SURGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURGE>(arg0, 9, b"SURGE", b"Sui Surge", x"537569205375726765206973206120686967682d656e65726779206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e2c206272696e67696e67206578636974656d656e7420616e6420666173742d706163656420636f6d6d756e69747920656e676167656d656e742e204974e2809973207065726665637420666f722074686f73652077686f20656e6a6f7920726964696e6720746865207761766573206f662063727970746f207769746820612066756e2c20706c617966756c20766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1827412367652671488/rFGc7g76.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SURGE>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

