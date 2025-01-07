module 0x2a5002ba7e7d44c6dc629f48a7fe9987b18f2ce48a6c6a4280e82722df11da12::wartocen {
    struct WARTOCEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTOCEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTOCEN>(arg0, 9, b"WARTOCEN", b"WAR", b"Token of WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5539dda-fdbe-4748-acd0-dfade1661270.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTOCEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARTOCEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

