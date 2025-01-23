module 0xa89c1b055ba69c525a537030a975b0c4782e8f880f80fd07fd87a1ea2abe5390::fatalftw {
    struct FATALFTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATALFTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATALFTW>(arg0, 6, b"FatalFTW", b"Fatalismftw", b"Elon Musk's new Path of Exile 2 character : Fatalismftw, the Kekius and Percy killer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_532180b828.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATALFTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATALFTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

