module 0x7ee998940d0dbc6dbc915ef7ccb64045b6225ca007ca1281c9887222c6c04451::rui {
    struct RUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUI>(arg0, 9, b"RUI", b"Ruimia", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdb095f6-0e30-43f8-9a62-04de05008c21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

