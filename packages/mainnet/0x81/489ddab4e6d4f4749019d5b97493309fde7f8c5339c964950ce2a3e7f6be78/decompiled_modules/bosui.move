module 0x81489ddab4e6d4f4749019d5b97493309fde7f8c5339c964950ce2a3e7f6be78::bosui {
    struct BOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSUI>(arg0, 6, b"BOSUI", b"BOOK OFSUI", b"Chapter 123: The Genesis of Gains \"Thou shalt ape into projects without hesitation, for fortune favors the degen.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rectangulo_1_370d70e160_3b3628384a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

