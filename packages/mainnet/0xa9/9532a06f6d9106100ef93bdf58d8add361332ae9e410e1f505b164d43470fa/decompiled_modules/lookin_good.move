module 0xa99532a06f6d9106100ef93bdf58d8add361332ae9e410e1f505b164d43470fa::lookin_good {
    struct LOOKIN_GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOKIN_GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOKIN_GOOD>(arg0, 9, b"SPON", b"Lookin good", b"This is a perfect token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2Foriginals%2F17%2F43%2F9e%2F17439ed53c82a22a551f4261bf25afe3.jpg&f=1&nofb=1&ipt=7c3159d75e2cb3c0d77a15e3c16fc2f05738281d1e99d554d7634074fd5425c7")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOKIN_GOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOKIN_GOOD>>(0x2::coin::mint<LOOKIN_GOOD>(&mut v2, 1000000000000000000, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOKIN_GOOD>>(v2, @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
    }

    // decompiled from Move bytecode v6
}

