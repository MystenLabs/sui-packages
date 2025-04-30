module 0x4c3df3adbb199f8c6610c3f2f789010062c9d047c49e620cc4a7913eef07f454::dadysui {
    struct DADYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADYSUI>(arg0, 6, b"DADYSUI", b"I A Dady Sui", b"Dady SUI - More than just a meme coin, we are a fusion of martial arts mastery and blockchain innovation. Through humor, relatability, and a powerful community, we aim to be the ultimate marketing force for SUI, driving growth with every move. Enter the dojo. Kick first, ask questions later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qsmthr_4f4633bd98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

