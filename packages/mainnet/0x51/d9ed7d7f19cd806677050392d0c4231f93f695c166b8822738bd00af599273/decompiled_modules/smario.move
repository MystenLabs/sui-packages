module 0x51d9ed7d7f19cd806677050392d0c4231f93f695c166b8822738bd00af599273::smario {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARIO>(arg0, 6, b"SMARIO", b"SUIMARIO", b"SUI Mario is the ultimate meme token adventure on the Sui blockchainwhere memes meet mayhem and Mario gets a crypto makeover! Inspired by the iconic Super Mario, SUI Mario is not just a token, its a whole pixel-powered movement. Players and holders can soon dive into a nostalgic, side-scrolling game experience just like the classicbut with a twist: its SUI Mario, where blockchain meets boss battles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_27e874dab4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

