module 0x8edb870a52379c5f0c4ac9a50d493492841867d1169ef13bc9cadb5c600b53b9::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DK>(arg0, 9, b"DK", b"DK73", b"WER3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9d37b2981cc5a645bf0c625c06cc76feblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

