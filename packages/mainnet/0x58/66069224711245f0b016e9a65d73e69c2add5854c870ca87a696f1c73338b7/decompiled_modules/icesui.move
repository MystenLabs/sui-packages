module 0x5866069224711245f0b016e9a65d73e69c2add5854c870ca87a696f1c73338b7::icesui {
    struct ICESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICESUI>(arg0, 6, b"ICESUI", b"SUI ICE TOKEN", b"ICE ICE BABY ICE. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6010258852295067152_y_2db399cc3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

