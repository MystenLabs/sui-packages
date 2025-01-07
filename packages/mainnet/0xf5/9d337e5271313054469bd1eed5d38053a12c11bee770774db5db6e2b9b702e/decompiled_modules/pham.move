module 0xf59d337e5271313054469bd1eed5d38053a12c11bee770774db5db6e2b9b702e::pham {
    struct PHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAM>(arg0, 9, b"PHAM", b"AnYen", b"Fyosay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5110b31a-dccf-4e1f-8e50-834780856862.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

