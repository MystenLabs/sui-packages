module 0x59ca5f85e5b7db8fd465bbc4aa0fd68353dac09ed37b8b551805c5537e768be2::aaaw {
    struct AAAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAW>(arg0, 6, b"AAAW", b"AAA Walter", b"AAA Walter is  a chad on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_d18f83abab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

