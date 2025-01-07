module 0xafa1ea69af0e0d70754ed2a6192e02b85074f013dd347a56e65577fc5af8767c::ghmi {
    struct GHMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHMI>(arg0, 6, b"GHMI", b"G Hami", b"G Hami is the memecoin that takes no prisoners. Inspired by the legendary Gangster Hami meme, this coin represents the raw energy of a community that doesnt back down. This isnt a coin for weak hands  its for true OGs who understand that real power lies in loyalty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3821_ef10fe2777.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

