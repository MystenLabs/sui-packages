module 0xb3deb1048665a354d38f3599a1d863dd2000fdc346726c82621c39f415b1684::rico {
    struct RICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICO>(arg0, 6, b"RICO", b"Rico The Porcupine", b"Rico the prehensile-tailed Brazilian Porcupine is celebrating his 9th birthday on April 2, 2025 He is a favorite of Cincinnati Zoo members and has become an online sensation. The zoo gift shop has several custom items inspired by Rico including his own 12 plush boop print.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlbgldbfeyl4my4s42y4sodfgjyi5dqu725hoyaynvahpfe7yosa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

