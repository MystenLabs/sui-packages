module 0xc9e686a6a39deaa22e5badff5148bb30f9ed1b0599a39664cf0f73325e3fc816::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"MeowWooF", x"4a6f696e20746865204d4557205061636b20746f206265206170617274206f662074686520666173746573742067726f77696e6720636f6d6d756e697479206f6e2053554921200a544f204441204d45574e4e4e4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Meow_Wooo_F_1_24fe86d663.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

