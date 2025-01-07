module 0x883c7bd0ca0762a8310ef8e9ffc252490e4608fd6fac961219b49e2e6d710253::penen {
    struct PENEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENEN>(arg0, 9, b"PENEN", b"jebd", b"hsnw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b16be28-6255-43c1-a339-d4f5cccf68a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

