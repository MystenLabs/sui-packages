module 0x2ebb5e7b0c9aaec4e10fb5c379f1b765706e429b1f42792c57af090adc267b5a::awsd {
    struct AWSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWSD>(arg0, 6, b"Awsd", b"asd", b"AAAASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih72r7n2jwvqo2xsxuc6vf4c5pqa7vtn57zvuca6j6tqnggdsi6pi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AWSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

