module 0x468706cdbd510a7d2c9d9fdd82fcde727105a4141bd3bcc608908be5a40bef14::dydr {
    struct DYDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYDR>(arg0, 9, b"DYDR", b"Daydreamer", x"44617920647265616d657220697320666f7220616c6c207468652062656c696576657273206f662063727970746f2c206576656e20696e20746865206368616c6c656e67696e6720776f726c6420796f75207374696c6c2062656c696576652063727970746f206973206865726520746f20737461792e20204c6574277320737072656164207468697320746f2074686520776f726c6420f09f8c8e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38954590-7f7b-47cf-a7f0-2cf9609a2c21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

