module 0x74dd4043c0ddbef6e620766f3349e953c68c8033a4bc64519c70d3ab91382aa8::zai {
    struct ZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAI>(arg0, 9, b"ZAI", b"Zesh AI", x"5a65736820697320746865206669727374204149204c61796572206f6e20535549207468617420757365732064617461206d6f64656c2064726976656e2070726f647563747320746f20736f6c766520616c6c206f662057656233e28099732067726f7774682c206d61726b6574696e6720616e6420636f6d6d756e697479206368616c6c656e6765732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1732100923231453184/n5YjbhvJ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZAI>>(0x2::coin::mint<ZAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

