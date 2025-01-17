module 0xa1d44e68ccab99e8f03916ee0694b0bd8b71cafc3c2817d6450e6533fc1bdd91::occo {
    struct OCCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCCO>(arg0, 6, b"OCCO", b"OctoCoin", b"Is a pirate? Is a octopus? No, is the f*cking OctoCoin!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3103_4cccc06200.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

