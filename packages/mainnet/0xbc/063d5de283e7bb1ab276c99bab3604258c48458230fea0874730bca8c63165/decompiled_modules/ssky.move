module 0xbc063d5de283e7bb1ab276c99bab3604258c48458230fea0874730bca8c63165::ssky {
    struct SSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSKY>(arg0, 6, b"SSKY", b"SUI SKY", b"$SSKY Thinking out loud, always looking into the blue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735595679854.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

