module 0x6c161db4a436c134abb01f8667d54c9192a7a15f4dc2968b7899eb51f56db263::wifpiglet {
    struct WIFPIGLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFPIGLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFPIGLET>(arg0, 6, b"WifPiglet", b"Sui Wif Piglet", x"4120776f6f6c656e207069676c657420697320636f6d696e6720746f2073756920666f726573742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piglet_vmake_2_f8a939373c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFPIGLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFPIGLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

