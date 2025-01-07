module 0xbc56e2530c582f25706d35a84831c75706b823aa3eac3654188868fabc2a0a3d::keksuis {
    struct KEKSUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKSUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKSUIS>(arg0, 6, b"Keksuis", b"KekSuis Maximus", x"456c6f6e204d75736b206973204b656b697573204d6178696d75730a576520617265204b656b53756973204d6178696d7573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735632142463.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKSUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKSUIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

