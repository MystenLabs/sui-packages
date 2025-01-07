module 0x801e0467f9f4b08bf1482406320ba8f0572755213033d7fa3bfd28a9ec79ab4c::pawg {
    struct PAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWG>(arg0, 6, b"PAWG", b"Phat Ass White Grouper", b"Come join Gary the Grouper on a road of obesity from devouring the other fish on the water chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6296_acdcc85309.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

