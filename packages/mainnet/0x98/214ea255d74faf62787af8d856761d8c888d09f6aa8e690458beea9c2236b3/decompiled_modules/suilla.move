module 0x98214ea255d74faf62787af8d856761d8c888d09f6aa8e690458beea9c2236b3::suilla {
    struct SUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLA>(arg0, 6, b"SUILLA", b"GODSUILLA", b"$GodSUIllais a prehistoric reptilian or dinosaurian monster that is amphibious or resides partially in the SUI, awakened and empowered after many years.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_34_19_6e1bee99a6_779bd3d686.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

