module 0xbddeb80b458dd78d06d712fc0f9488e3bb0fa6ae43266e96e5cb83ed5f8d93ce::srna {
    struct SRNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRNA>(arg0, 6, b"SRNA", b"RNA on SUI", x"4465636f646520746865206675747572652e204a6f696e2024524e412e200a0a49207468696e6b20524e412068617320616d617a696e6720706f74656e7469616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TLE_Zda3_U_400x400_951a412416.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

