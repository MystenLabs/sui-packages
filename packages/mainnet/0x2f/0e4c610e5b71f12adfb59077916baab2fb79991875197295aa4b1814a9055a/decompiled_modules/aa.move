module 0x2f0e4c610e5b71f12adfb59077916baab2fb79991875197295aa4b1814a9055a::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA>(arg0, 6, b"AA", b"TOKEN", b"1111111111111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735919912442.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

