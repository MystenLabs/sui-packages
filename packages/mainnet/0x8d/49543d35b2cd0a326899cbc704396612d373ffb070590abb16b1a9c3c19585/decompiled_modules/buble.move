module 0x8d49543d35b2cd0a326899cbc704396612d373ffb070590abb16b1a9c3c19585::buble {
    struct BUBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLE>(arg0, 6, b"BUBLE", b"BUBBLE ON SUI", b"$BUBL GUM bubbles are everywhere water is, and Sui is no exception. They pump, float, and boil they're fun. Sui is water, water needs BUBLs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037492_ff2ecb5b4f_88be23a998.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

