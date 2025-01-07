module 0x4fdf933a67d01513c79dd5ccdefef0d74a054430b7b30b86758b6c1c51d85ee8::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 6, b"NEPTUNE", b"Neptune God Of The SUI", b"Neptune (Latin: Neptnus [nptuns]) is the god of freshwater and the sea in the Roman religion. He is the counterpart of the Greek god Poseidon.In the Greek-inspired tradition, he is a brother of Jupiter and Pluto, with whom preside over the realms of heaven, the earthly world (including the underworld), and the seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/europe_italy_florence_statue_roman_god_neptune_11145264_jpg_57d7fc46b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPTUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

