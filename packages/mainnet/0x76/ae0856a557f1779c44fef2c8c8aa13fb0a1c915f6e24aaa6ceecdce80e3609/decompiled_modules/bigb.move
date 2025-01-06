module 0x76ae0856a557f1779c44fef2c8c8aa13fb0a1c915f6e24aaa6ceecdce80e3609::bigb {
    struct BIGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGB>(arg0, 6, b"BIGB", b"Big Blue", b"Meet big Blue he cant stop dancing come join him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5960_f3b516550c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

