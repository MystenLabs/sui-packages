module 0x82dff1828b1ecd7f8fc7f181a7a17a5fad9afcdb557eccc25f6b9a86ee9309cc::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"MADDOGCOIN", b"just for fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bf51bba5461f33687bf5dd09f074dcb1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

