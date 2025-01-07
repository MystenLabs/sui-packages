module 0xf98d9be84aa525ba82a87e344cbf63c65d108c4508093ce3fbf1d7116ce762b0::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 6, b"JOYCAT", b"Joycat", b"JOYCAT is more than just a pet; is the embodiment of the spirit of $MOG and the playful spirit of internet meme culture. Representing decentralized creativity and community power, JOYCAT brings together the whimsical side of SUI with the unstoppable drive toward success. As a guardian of cosmic domination, JOYCAT unites the SUI community, turning internet culture into a force shaping the crypto landscape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040092_8e7184ed33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

