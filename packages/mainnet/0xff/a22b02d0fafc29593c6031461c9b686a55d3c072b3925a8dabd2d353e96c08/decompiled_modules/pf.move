module 0xffa22b02d0fafc29593c6031461c9b686a55d3c072b3925a8dabd2d353e96c08::pf {
    struct PF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PF>(arg0, 6, b"PF", b"PinkFish", b"Pink fish swim in sui river to pump to the sky . Be ready, be an holder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FISH_abb11e5431.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PF>>(v1);
    }

    // decompiled from Move bytecode v6
}

