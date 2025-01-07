module 0xa078f9a3c152a4273351463bb496283d6e15b82bc4f0b4dfdc4790727e274644::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"Cult", b"SUI cult", b"SUI Cult  The memecoin for true degens who believe in nothing but pure chaos and vibes!  Forget utility, forget roadmaps  this is a token for those who follow blindly, meme religiously, and SUI heavily. Join the cult, sacrifice your logic, and worship the SUI Cult god!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cult_b4faeb84d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

