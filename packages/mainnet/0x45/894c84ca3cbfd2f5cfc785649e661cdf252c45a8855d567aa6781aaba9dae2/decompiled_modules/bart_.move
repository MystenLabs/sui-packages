module 0x45894c84ca3cbfd2f5cfc785649e661cdf252c45a8855d567aa6781aaba9dae2::bart_ {
    struct BART_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BART_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BART_>(arg0, 9, b"Bart_", b"bluebeam", b"bluebeam bart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9fa50a4233620c5f362b060a56a43adbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BART_>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BART_>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

