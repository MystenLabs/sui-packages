module 0x193157c38ce774f586693bc383a2c2009307d06dbbb1c2f5a61542bceb664822::dddd {
    struct DDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDD>(arg0, 9, b"DDDD", b"DDD", b"DDDDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file.walletapp.waveonsui.com/images/wave-pumps/c524121d-0a91-434d-ab4f-c7d6c17f2101.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

