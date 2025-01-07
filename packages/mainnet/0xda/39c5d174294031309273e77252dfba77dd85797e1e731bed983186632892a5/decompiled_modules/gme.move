module 0xda39c5d174294031309273e77252dfba77dd85797e1e731bed983186632892a5::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GME on SUI", x"5768617420612062656175746966756c2064617920697420697320696e2074686520646567656e2063727970746f2073706163652e0a41726520796f7520726561647920666f72207468652062696767657374206c61756e6368206f6e2024535549207965743f0a54473a2068747470733a2f2f742e6d652f676d655f6f6e5f7375690a5745423a2068747470733a2f2f7777772e676d656f6e7375692e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0394_f8a720d54d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

