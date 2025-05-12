module 0xe2b707c1d5ec95709181096eace8c3870f60fda737028939719fe03204c9882d::mva {
    struct MVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVA>(arg0, 6, b"MvA", b"100 Man Vs 1 Ape", x"313030206d656e2076732031204170652c2077686f20776f756c642077696e3f0a0a54686520426967676573742048797065206f6620323032352c20224d616e207673204265617374222c204d6f737420476f6f676c652764205175657374696f6e206f6620746865207765656b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069021_43f68cea2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

