module 0x92ae3d38f5c86575783d13bdb45aea5ec65f7bf4c28706753ed74dcaf52fcee::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"SUI DUCK", b"On the SUI blockchain, there lived a mysterious group of ducks in a digital realm known as \"Duck Village.\" These ducks were no ordinary creatures; they were guardians of the blockchain, each carrying a unique identity and a responsibility to ensure the security and decentralization of data on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_01613784f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

