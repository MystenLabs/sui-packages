module 0xb0c9d21aefb4311f01add1d65ace55ed34240a9a125c9bb9502f0330c79202c7::syan {
    struct SYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYAN>(arg0, 6, b"SYAN", b"Super Saiyan Cat", b"No tuna? Time to unleash the ultimate power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_231812_ac475cdd69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

