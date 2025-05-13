module 0x8616fbac2f91025517d9ab97abc476e57e127816aedee6915edaba72e0258f51::ponzi {
    struct PONZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONZI>(arg0, 9, b"PONZI", b"Charles Ponzi", x"504f4e5a49205820436f6d6d756e6974795c6e546865206f6666696369616c2068756220666f722074686520646567656e65726174657320616e6420647265616d6572732077686f20656d627261636520746865206368616f73206f662024504f4e5a492e204275696c742062792074686520666561726c6573732c20666f722074686520666561726c6573732e20f09f8c805c6e5c6ef09f92b0205374616b652c204561726e2c20446f6d696e6174655c6ef09f8c90204a6f696e2074686520506f6e7a69207265766f6c7574696f6e5c6ef09f9a80205768657265206761696e73206d65657420696e73616e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/cc7QwdrR/Chat-GPT-Image-May-13-2025-06-55-40-PM.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONZI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONZI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

