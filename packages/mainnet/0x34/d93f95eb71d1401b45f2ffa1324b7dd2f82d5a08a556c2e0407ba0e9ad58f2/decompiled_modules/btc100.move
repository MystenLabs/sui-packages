module 0x34d93f95eb71d1401b45f2ffa1324b7dd2f82d5a08a556c2e0407ba0e9ad58f2::btc100 {
    struct BTC100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100>(arg0, 9, b"BTC100", b"btc100k", b"in memory of those who did not buy btc up to 100k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2d4cfe250c9079154ae70007478b3141blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC100>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

