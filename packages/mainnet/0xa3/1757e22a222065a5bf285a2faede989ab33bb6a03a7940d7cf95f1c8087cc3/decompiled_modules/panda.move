module 0xa31757e22a222065a5bf285a2faede989ab33bb6a03a7940d7cf95f1c8087cc3::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"Panda", b"SuiPanda", b"**SuiPanda**  the cuddliest meme coin on the blockchain!  Powered by bamboo and good vibes, SuiPanda is here to roll through the crypto jungle with its unstoppable fluffiness. Forget going \"to the moon\"  were napping in the treetops! Whether you're a serious investor or just here for the memes, SuiPanda is your bamboo-powered ticket to a world of panda-monium.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0398_8fff84f216.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

