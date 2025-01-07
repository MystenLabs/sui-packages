module 0xfb3319d7da84f1e2ad80eb3b27ffdf9082ef8115cde1a1dc8a176e5a2f75a0dd::cwif {
    struct CWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIF>(arg0, 6, b"CWIF", b"Crab Wif", b"Who does BRO think HE IS???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_fish_6ed4468bda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

