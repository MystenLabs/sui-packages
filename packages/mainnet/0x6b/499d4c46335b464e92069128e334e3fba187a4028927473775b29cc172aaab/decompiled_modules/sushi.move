module 0x6b499d4c46335b464e92069128e334e3fba187a4028927473775b29cc172aaab::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 9, b"SUSHI", b"sushi", b"Food sushi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c39120c3-a63c-41db-b9b1-bd07ddaf4959.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

