module 0x7beea133a8273816447399d6f984914f0eec586f13fe00a5c2ecb717292b1e0f::diddler {
    struct DIDDLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDLER>(arg0, 6, b"DIDDLER", b"Diddler", b"Diddler is a cryptocurrency inspired by the entrepreneurial empire of Sean \"Diddy\" Combs, representing ambition, innovation, and luxury. Just like Diddy's ability to evolve and reinvent himself across music, fashion, and business, this coin is designed to be versatile and future-focused in the crypto space. Diddler embodies the relentless hustle and creativity that has defined Diddy's career, making it a symbol of empowerment and success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DIDDLER_c7387248bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

