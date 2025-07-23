module 0x77348467d4046e72357cc7aba38db2cab021534117531417c1fff6ae587f8c2c::mutl {
    struct MUTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTL>(arg0, 6, b"MUTL", b"Mutlley Mutt", x"57656c636f6d6520746f204d7574746c6579204d75747420436f696e0a4a6f696e2066756e6e7920626f6e657320616e6420667269656e647320696e206f6e65206f66207468652066756e6e6965737420636f6d6d756e6974792d64726976656e206d656d65636f696e73206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib5jksax6brgjppoz3hhgu4rolc7avbn7r4kqaus4fzj3dr5d3jwm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

