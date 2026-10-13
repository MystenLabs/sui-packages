module 0x297fd08a80a7b1f15751e13c2bac1f90490fdd4e8395596a1733a2a0f03fac57::booegg {
    struct BOOEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nSpookEgg";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dAn egg too terrified of being scrambled, so it put on a bedsheet to scare away the chef. Now it haunts the blockchain as a friendly little phantom, permanently hiding its shell until it's time to moon.";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<BOOEGG>(arg0, 6, b"BOOEGG", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/3KOMXcvt2lsGtWV9")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOEGG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOEGG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

