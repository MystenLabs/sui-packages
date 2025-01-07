module 0x65150cfca2ba3f3b9f5e5527a44adddc4e8772506aa2244b441132a855ba3f06::rid {
    struct RID has drop {
        dummy_field: bool,
    }

    fun init(arg0: RID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RID>(arg0, 9, b"RID", b"RIDMARK", b"It's a meme of myself. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76a6d9c6-1208-475c-a78c-1cdae86ca9de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RID>>(v1);
    }

    // decompiled from Move bytecode v6
}

