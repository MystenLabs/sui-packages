module 0xd2f908e5970548411f73102c39dafd1ae85ebc2ad920d489544cd2aa5ce7f936::popdeeng {
    struct POPDEENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDEENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDEENG>(arg0, 6, b"POPDEENG", b"POPDEENG on SUI", b"first POPDEENG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036439_7fc5250978_24faf127af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDEENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDEENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

