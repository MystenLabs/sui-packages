module 0x21eec217dd4c47438e2cd6aaec2f028de0a7bdb36b24efb9bace4fdf22fe3889::kido {
    struct KIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDO>(arg0, 9, b"KIDO", b"KAIDAWG", b"Kai is a black poodle who like to cuddle, bark at motorcycles and chase people for belly rubs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11f4e592-2d0f-43de-bb1a-ccbee51b2be4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

