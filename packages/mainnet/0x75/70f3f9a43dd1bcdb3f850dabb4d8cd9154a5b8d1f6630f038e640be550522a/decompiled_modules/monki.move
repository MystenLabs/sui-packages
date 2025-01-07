module 0x7570f3f9a43dd1bcdb3f850dabb4d8cd9154a5b8d1f6630f038e640be550522a::monki {
    struct MONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKI>(arg0, 6, b"MONKI", b"Monki Jungle", b"Just a cute little monkey with BIG dreams. My goal? To become the first billionaire monkey through the magic of crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_23bb7faac2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

