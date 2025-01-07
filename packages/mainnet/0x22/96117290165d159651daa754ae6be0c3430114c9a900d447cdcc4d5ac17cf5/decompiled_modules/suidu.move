module 0x2296117290165d159651daa754ae6be0c3430114c9a900d447cdcc4d5ac17cf5::suidu {
    struct SUIDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDU>(arg0, 6, b"SUIDU", b"Suidu", b"suidu.xyz . Here to make waves on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L8_H98_an_400x400_c13298d267.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

