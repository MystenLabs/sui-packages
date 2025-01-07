module 0x751d2a50449ca9ce9d8fc79cf76297615c795c7b275c363abfec1b02ffa5339c::caech {
    struct CAECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAECH>(arg0, 9, b"CAECH", b"Phiech", b"Wellcome to my meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4d2e025-d444-4914-9fe7-b3f65d893a97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAECH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAECH>>(v1);
    }

    // decompiled from Move bytecode v6
}

