module 0x345a7c40ac1fb294ff4fa836f3fae2a15e6baa515d6f94bf67c63d98b89586ad::thex {
    struct THEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEX>(arg0, 6, b"THEX", b"The X", b"The X is a leading meme coin within the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742077928696.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

