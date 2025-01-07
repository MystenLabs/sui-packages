module 0xe1a38ab74c496568e8961e941f860c1757c15918f2f1b045978c3691480b5cb::msme {
    struct MSME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSME>(arg0, 9, b"MSME", b"Msmepad", b"i mistype the ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45885615-ef89-41b7-ada5-d0097f6fb49c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSME>>(v1);
    }

    // decompiled from Move bytecode v6
}

