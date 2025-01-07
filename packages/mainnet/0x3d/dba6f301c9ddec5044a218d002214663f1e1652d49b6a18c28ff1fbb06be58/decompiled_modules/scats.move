module 0x3ddba6f301c9ddec5044a218d002214663f1e1652d49b6a18c28ff1fbb06be58::scats {
    struct SCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATS>(arg0, 9, b"SCATS", b"SuiCats ", b"The world of Sui Cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c8dc81f-7a98-4a31-99b6-e179388aafa6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

