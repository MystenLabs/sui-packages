module 0xa68067cf44fc73968aaf4e52223266d85427797c27e8ca1cf26f7496078f7a8b::sxt {
    struct SXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXT>(arg0, 6, b"SXT", b"SuixElonTrump", b"uiXElonTrump (SXT) is the coin that brings the daring spirit of Elon Musk and the tenacious drive of Donald Trump to the blockchain world, designed to thrive on the Sui network. The recent election has spotlighted the power of voice and innovation, and SXT aims to capture that momentum. Whether you're here for the memes, the hype, or the chance to be part of a unique digital community, SXT offers a playful yet impactful way to jointhemovement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_photo_561b39e827.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

