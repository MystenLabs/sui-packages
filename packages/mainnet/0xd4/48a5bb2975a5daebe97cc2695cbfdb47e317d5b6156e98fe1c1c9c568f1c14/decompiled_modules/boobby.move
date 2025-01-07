module 0xd448a5bb2975a5daebe97cc2695cbfdb47e317d5b6156e98fe1c1c9c568f1c14::boobby {
    struct BOOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBBY>(arg0, 9, b"BOOBBY", b"Babayaro", b"Token for charity and support", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb90fc8d-1720-4af0-8dca-b1b69ad40a07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

