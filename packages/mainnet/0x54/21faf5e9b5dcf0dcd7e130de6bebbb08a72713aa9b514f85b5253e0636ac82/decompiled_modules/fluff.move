module 0x5421faf5e9b5dcf0dcd7e130de6bebbb08a72713aa9b514f85b5253e0636ac82::fluff {
    struct FLUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFF>(arg0, 9, b"FLUFF", b"Fluff ", b"FluffCoin (FLUF): A fun, community-driven meme coin that brings joy and playfulness to crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6b2c2c9-12b1-4fab-bc37-098b14d187cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

