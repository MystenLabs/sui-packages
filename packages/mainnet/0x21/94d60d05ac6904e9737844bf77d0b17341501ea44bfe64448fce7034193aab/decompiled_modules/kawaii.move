module 0x2194d60d05ac6904e9737844bf77d0b17341501ea44bfe64448fce7034193aab::kawaii {
    struct KAWAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAWAII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAWAII>(arg0, 6, b"KAWAII", b"Kawaii Girls", b"KAWAII GIRLS COLLECTIONS AND NFTS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g5wt39akqw501_97a0b38e91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAWAII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAWAII>>(v1);
    }

    // decompiled from Move bytecode v6
}

