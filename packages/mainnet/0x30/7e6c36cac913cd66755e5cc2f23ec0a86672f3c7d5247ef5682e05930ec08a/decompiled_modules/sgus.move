module 0x307e6c36cac913cd66755e5cc2f23ec0a86672f3c7d5247ef5682e05930ec08a::sgus {
    struct SGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGUS>(arg0, 9, b"SGUS", b"SuiGus ", b"SuiGus best token on Sui. SuiGus no, capitan SuiGus!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7a7a13c-27cf-496e-8c5b-8482a0502f94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

