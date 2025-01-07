module 0x69d2a5d9002e55ac6f4a4a49fa0d112d2cb54bcb1e7fda2a4ae26cf6f5dab97f::ddlp {
    struct DDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDLP>(arg0, 6, b"DDLP", b"DARING DOLPHIN", b"Riding the meme waves with grace and speed. Daring Dolphin is flipping for gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_052252802_bbd49d018e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

