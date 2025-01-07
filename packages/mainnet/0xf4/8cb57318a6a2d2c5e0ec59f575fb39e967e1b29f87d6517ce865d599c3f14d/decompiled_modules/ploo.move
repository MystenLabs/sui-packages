module 0xf48cb57318a6a2d2c5e0ec59f575fb39e967e1b29f87d6517ce865d599c3f14d::ploo {
    struct PLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOO>(arg0, 6, b"PLOO", b"Ploo on SUI", b"hi im Ploo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/341_a2dd8c1bd3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

