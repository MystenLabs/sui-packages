module 0xccb0520bfb639c79d2b0204c648f7c2eb016694754bcbf64ecb6740d64d66ff2::wag {
    struct WAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAG>(arg0, 6, b"WAG", b"BLUE HUSKY", x"424c554520504c415946554c204859534b592c0a484553204e4f54204a55535420464c554646592c0a48452753204845524520544f204c45414420544845205041434b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/309453c0_342c_4fc4_be26_31fec07097a6_2fdf862993.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

