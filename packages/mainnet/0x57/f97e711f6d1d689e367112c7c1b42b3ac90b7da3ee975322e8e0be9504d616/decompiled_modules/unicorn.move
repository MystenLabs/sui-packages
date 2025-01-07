module 0x57f97e711f6d1d689e367112c7c1b42b3ac90b7da3ee975322e8e0be9504d616::unicorn {
    struct UNICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICORN>(arg0, 6, b"Unicorn", b"UWU", x"756e69636f726e732061726520435554452c206375746572207468616e20750a697473206a757374206120686f72736520776974682061207765697264207468696e67206f6e206974732068656164206465616c2077697468206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_e53864353c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

