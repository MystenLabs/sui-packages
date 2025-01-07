module 0x8abb4fa79dbfb4cb5e7275891262705bdf225ac5b4b2fdc03f430dc36039b6e1::ubr {
    struct UBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBR>(arg0, 9, b"UBR", b"umbrella", x"656e737572696e6720796f757220706f7274666f6c696f2073746179732064727920616e642070726f66697461626c65207468726f75676820616e792073746f726d20e29882efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0b053e1-20eb-4dbb-a848-3a9c429b967b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

