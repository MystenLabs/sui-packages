module 0x7123e06696ec408684f4133a7972383b319b21058240ec6f97c32d2d805938b4::whiz {
    struct WHIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHIZ>(arg0, 6, b"WHIZ", b"The Whiz", b"Whiz the SUI Wizard is a mystical meme force in the SUIverse, casting spells of hype and channeling pure degen energy to unleash magic, memes, and chaos across the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicf7nwnxfoxeuo7lkkta5kt7wo6qnzos2rj5spjkuinxam5pyp3ou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHIZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

