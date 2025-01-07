module 0x6054f9aac0a0f4829976c72bd6e337f23a988ab6f839f1bcc6dfdaf27ade4ceb::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 6, b"CATSUI", b"SUI CATHENA", b"Cathena is a decentralized cryptocurrency built on the SUI blockchain, inspired by the enchanting world of cats and the wisdom of Athena, the Greek goddess of strategy and wisdom. Rooted in the universally beloved cat meme culture, Cathena blends the playful charm of felines with the intellectual depth of Athena, creating a unique digital asset that captivates both meme enthusiasts and cryptocurrency investors alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cat_28ce0dc447.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

