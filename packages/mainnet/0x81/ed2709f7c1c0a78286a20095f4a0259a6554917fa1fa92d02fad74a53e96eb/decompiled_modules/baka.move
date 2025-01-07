module 0x81ed2709f7c1c0a78286a20095f4a0259a6554917fa1fa92d02fad74a53e96eb::baka {
    struct BAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKA>(arg0, 6, b"BAKA", b"Tsundere", b"I-its not like I want you to buy me or anything, BAKA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tsundere_e08de2b030.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

