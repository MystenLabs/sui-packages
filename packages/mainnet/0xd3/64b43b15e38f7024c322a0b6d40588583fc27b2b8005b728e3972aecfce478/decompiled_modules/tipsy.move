module 0xd364b43b15e38f7024c322a0b6d40588583fc27b2b8005b728e3972aecfce478::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPSY>(arg0, 6, b"TIPSY", b"TIPSY CTO", b"A spirited narwhal named Tipsy runs a blockchain start-up called \"MOVEPUMP.\" Every time someone invests in his coin, he takes a celebratory chug of beer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tripsy_9dc0d7b483.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

