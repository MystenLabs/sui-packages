module 0xe9c0053961aee46374cbcd13845bcb3c6482056f52cf34db416115254ab70b03::suimsuit {
    struct SUIMSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMSUIT>(arg0, 9, b"SUIMSUIT", b"SUIm SUIt", b"Summer ready? Grab your SUIm SUIt and let's dive into the pool full of SUImmers! Telegram: https://t.me/SUIm_SUIt Twitter: https://x.com/SUIm_SUIt Website: https://suimsuit.site", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMSUIT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMSUIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

