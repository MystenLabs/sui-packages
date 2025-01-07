module 0xbdf3fee79e1bef904d32868c433d0e4481b45a0b2b03adad9692d9b7fd18451::bndr {
    struct BNDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNDR>(arg0, 9, b"BNDR", b"BANDEROS", b"Banderos is a sustainable token aimed at promoting eco-friendly projects and renewable energy initiatives. Join the movement to protect our planet and invest in a greener future while earning rewards for eco-conscious actions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2fe9c72-0294-4eac-814e-4f1a7c007015.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

