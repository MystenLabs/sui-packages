module 0x6c2e55c95011f51ebb95773e257bd2bf0b70ce2bc8b000fa880ddfb11e147f58::granpop {
    struct GRANPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRANPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRANPOP>(arg0, 6, b"Granpop", b"Granpop  on Sui", b"Sui Gran, the OG gangsta grandpop, dripping in style and fueled by an unrelenting passion for the Sui meme universe. We're reviving the golden days of meme season, sparking a new wave of meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5829922349586170767_y_da78e2e5fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRANPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRANPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

