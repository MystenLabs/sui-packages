module 0x31a8ce593f75e923ac9921ee7ecddd450b1d97465d937cf2992ea63711bbd8a9::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"LOL Guy", b"OG LOL Guy from 4chan is now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745500689122.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

