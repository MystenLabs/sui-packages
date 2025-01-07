module 0xf63617a3c0e7ec85b7c41411f923e3540c33368a98f2e76feb78276e5126d896::suilamb {
    struct SUILAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMB>(arg0, 6, b"SUILAMB", b"suilamb", b"SUILAMB on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_15_34_22_4dfe32d3ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

