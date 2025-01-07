module 0xd326adf179c9d5da6402be0f178a3744e1aba353418bf6fbdfe816d33ea1dce6::blua {
    struct BLUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUA>(arg0, 6, b"BLUA", b"Blue Ayed", b"Who needs sonar when youve got eyes like this?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_151051_9272b1654c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

