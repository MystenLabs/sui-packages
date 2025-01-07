module 0x2cfd6949534d22c3f3f08f087e7e456881233fe5e4d4348cfbf4363c9c5b90f::uejdn {
    struct UEJDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UEJDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UEJDN>(arg0, 9, b"UEJDN", b"nzndn", b"hebdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7944d3c7-cb21-40e1-8583-6f9bfa8fb1de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UEJDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UEJDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

