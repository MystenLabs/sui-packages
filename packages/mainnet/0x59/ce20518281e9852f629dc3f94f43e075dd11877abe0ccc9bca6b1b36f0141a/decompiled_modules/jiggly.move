module 0x59ce20518281e9852f629dc3f94f43e075dd11877abe0ccc9bca6b1b36f0141a::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"Jiggly on Sui", x"54686520756e6f6666696369616c20506f6bc3a96d6f6e20666f72206d6f6f6e626167732e696f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcjgbwtz7vc2xkays4bgntoxhgnxhgnueijfmzwpnirxjh6uqqka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

