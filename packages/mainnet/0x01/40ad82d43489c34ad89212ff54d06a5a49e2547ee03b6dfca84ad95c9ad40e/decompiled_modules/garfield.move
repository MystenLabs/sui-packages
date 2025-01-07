module 0x140ad82d43489c34ad89212ff54d06a5a49e2547ee03b6dfca84ad95c9ad40e::garfield {
    struct GARFIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARFIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARFIELD>(arg0, 9, b"GARFIELD", x"4761726669656c64f09f9088", b"Cartoon orange cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd3c50c7-39b4-4a08-bdd9-692ffb1b36e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARFIELD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARFIELD>>(v1);
    }

    // decompiled from Move bytecode v6
}

