module 0x9b1a66edbcc95666e3edded21d1a1d3de0f906d299bf1847b91a263555027a47::duh {
    struct DUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUH>(arg0, 6, b"DUH", b"DUH SUI", x"6920616d207469726564206f6620616c6c20746865206f766572636f6d706c6963617465642c207472792d68617264207468696e6773206f75742074686572652e2e206a757374206475682e6475682e6475682e6475682e6475680a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/duh_05_a00373df9f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

