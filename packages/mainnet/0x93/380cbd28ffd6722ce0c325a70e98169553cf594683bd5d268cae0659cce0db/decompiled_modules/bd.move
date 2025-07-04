module 0x93380cbd28ffd6722ce0c325a70e98169553cf594683bd5d268cae0659cce0db::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 6, b"BD", b"black dude", b"BUY IF U LIKE BLACK DUDES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751658381859.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

