module 0xfb132d830dcffdaac9894d765839948e9185f0e00bfe8557ce7003baaf7e8a0a::godsuilla {
    struct GODSUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODSUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODSUILLA>(arg0, 6, b"GODSUILLA", b"GOD-SUI-LLA", b"$GodSUIllais a prehistoric reptilian or dinosaurian monster that is amphibious or resides partially in the SUI, awakened and empowered after many years.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_34_19_6e1bee99a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODSUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODSUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

