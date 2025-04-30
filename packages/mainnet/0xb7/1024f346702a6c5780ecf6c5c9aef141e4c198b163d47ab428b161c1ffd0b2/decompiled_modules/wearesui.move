module 0xb71024f346702a6c5780ecf6c5c9aef141e4c198b163d47ab428b161c1ffd0b2::wearesui {
    struct WEARESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEARESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEARESUI>(arg0, 6, b"WEARESUI", b"We Are Sui", b"We Are SUI - More than just a meme coin, we are a fusion of martial arts mastery and blockchain innovation. Through humor, relatability, and a powerful community, we aim to be the ultimate marketing force for SUI, driving growth with every move. Enter the dojo. Kick first, ask questions later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2pxa5f_cd4e0e7efc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEARESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEARESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

