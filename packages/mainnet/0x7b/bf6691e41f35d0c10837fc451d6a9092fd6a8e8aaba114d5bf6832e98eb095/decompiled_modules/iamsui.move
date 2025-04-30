module 0x7bbf6691e41f35d0c10837fc451d6a9092fd6a8e8aaba114d5bf6832e98eb095::iamsui {
    struct IAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMSUI>(arg0, 6, b"IAMSUI", b"I AM SUI", b"I AM SUI - More than just a meme coin, we are a fusion of martial arts mastery and blockchain innovation. Through humor, relatability, and a powerful community, we aim to be the ultimate marketing force for SUI, driving growth with every move. Enter the dojo. Kick first, ask questions later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IAMSUI_PFP_01e_946aa2bad7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

