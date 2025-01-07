module 0x1c46580f901beda4fcdad389b49f9f8f38d383c44329aaad8e9fbb28bfc943cf::sui_z {
    struct SUI_Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_Z>(arg0, 6, b"SUIZ", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_Z>>(v1);
        0x2::coin::mint_and_transfer<SUI_Z>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_Z>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

