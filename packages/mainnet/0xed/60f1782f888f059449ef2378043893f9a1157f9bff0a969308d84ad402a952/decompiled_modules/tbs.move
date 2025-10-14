module 0xed60f1782f888f059449ef2378043893f9a1157f9bff0a969308d84ad402a952::tbs {
    struct TBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBS>(arg0, 9, b"TBS", b"TurboSui", x"5468652066617374657374206d656d6520636f696e206f6e2074686520537569204e6574776f726b20e29aa10a4275696c7420666f722073706565642c20706f77657265642062792074686520636f6d6d756e69747920f09f92a50a4a6f696e2074686520747572626f206d6f76656d656e7420e28094206d656d65732c2061697264726f707320262066756e206e6f6e73746f70210af09f8c9020506f776572656420627920426c6173742e66756e207c205469636b65723a20245442530a23547572626f537569202353756945636f73797374656d2023426c61737446756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TBS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBS>>(v2, @0xd42d4b72782bbe77384be87f086a6c8e2f7c54dad9b9f8c4e058bccf24afeab);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

