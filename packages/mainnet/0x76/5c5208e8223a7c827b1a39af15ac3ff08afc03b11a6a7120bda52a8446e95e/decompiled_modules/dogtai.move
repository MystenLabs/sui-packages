module 0x765c5208e8223a7c827b1a39af15ac3ff08afc03b11a6a7120bda52a8446e95e::dogtai {
    struct DOGTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTAI>(arg0, 6, b"DOGTAI", b"DogTranslatorAI", b"Ever wondered what your dog is REALLY thinking? With the Dog Translator Ai, you can finally decode those barks and growls into actual words!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_e704322caf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

