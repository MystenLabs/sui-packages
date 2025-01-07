module 0x8299bb6011d71b6476be8a4d9d9b749aa826ccabc40c56ceb95e44cd82f7dca6::crybananacat {
    struct CRYBANANACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYBANANACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYBANANACAT>(arg0, 6, b"CRYBANANACAT", b"crybananacat", b"CryBananaCat is a playful memecoin inspired by the beloved internet meme of a crying cat dressed as a banana. This whimsical token captures the hearts of meme enthusiasts and crypto lovers alike, offering a unique blend of humor and investment potential. Join our vibrant community and participate in fun events, contests, and exclusive NFT drops featuring our adorable mascot. As we spread joy and laughter, dont miss your chance to ride the wave as CryBananaCat sets its sights on the moon! Buy now and be part of this exciting journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CRYBANCAT_logo_9267465595.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYBANANACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYBANANACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

