module 0xab9bdfde2da168974c86ab7d5c8cb492d59e881acc316dd8eb0fd39cf2482193::ctyy {
    struct CTYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTYY>(arg0, 9, b"CTYY", b"XYZY", b"JINITAIMEI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b3020f697fefd7ba493b608e705be8edblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTYY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTYY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

