module 0xb3903ba21b7f50b236d1c8e519c80d22d03751ac7e595e7c47c511559f7439::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"sui dog", b"the official SUI dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_in_me_8d0220682a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

