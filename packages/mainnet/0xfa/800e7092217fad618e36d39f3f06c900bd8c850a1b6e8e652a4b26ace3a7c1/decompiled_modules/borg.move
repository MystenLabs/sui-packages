module 0xfa800e7092217fad618e36d39f3f06c900bd8c850a1b6e8e652a4b26ace3a7c1::borg {
    struct BORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORG>(arg0, 6, b"BORG", b"SUIBORG", b"Suiborg is an innovative cryptocurrency project built on the Sui Network, designed to harness the power of blockchain technology while offering a unique approach to digital assets. Suiborg represents a forward-thinking initiative that combines cutting-edge technology with a strong commitment to community-driven development.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiborg_118fb80c81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

