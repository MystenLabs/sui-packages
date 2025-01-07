module 0x77d147bea6afaca81ce169823b24f24ef507c7a60548474e57a00f41ff1dd5ee::pdn {
    struct PDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDN>(arg0, 9, b"PDN", b"Pandana", b"Pandana meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1f1f665-45fa-4b7d-a1b4-e3618413180d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

