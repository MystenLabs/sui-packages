module 0xebf87a07ede7880e5dafc00331837dab786ad77c4b9546f0bec1f083100ae1e8::memek_rfeasrdc {
    struct MEMEK_RFEASRDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDC>(arg0, 6, b"MEMEKRFEASRDC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDC>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

