module 0x93bc1ae33d3f1c923f0268df9be83e47d5142c5a924945fb9355738fbbc8c443::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"terminal of fun SUI", b"An AI-based bot that analyzes the token market on the http://pump.fun platform and learns how to trade by buying and selling tokens. SUI version.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmcWJxP3NoHjw5heLqQ7bdfn1CsTrNNCvqYtX4QKDEgkeY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

