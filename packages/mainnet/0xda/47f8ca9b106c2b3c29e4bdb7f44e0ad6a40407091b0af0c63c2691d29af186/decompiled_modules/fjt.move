module 0xda47f8ca9b106c2b3c29e4bdb7f44e0ad6a40407091b0af0c63c2691d29af186::fjt {
    struct FJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FJT>(arg0, 6, b"FJT", b"Fujitora", b"shibaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763633631395.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FJT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FJT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

