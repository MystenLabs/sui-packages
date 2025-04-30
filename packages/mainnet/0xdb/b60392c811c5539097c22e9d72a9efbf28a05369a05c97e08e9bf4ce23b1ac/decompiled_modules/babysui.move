module 0xdbb60392c811c5539097c22e9d72a9efbf28a05369a05c97e08e9bf4ce23b1ac::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 6, b"BABYSUI", b"Baby Sui", b"Baby SUI - More than just a meme coin, we are a fusion of martial arts mastery and blockchain innovation. Through humor, relatability, and a powerful community, we aim to be the ultimate marketing force for SUI, driving growth with every move. Enter the dojo. Kick first, ask questions later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jdr4dh_262a973044.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

