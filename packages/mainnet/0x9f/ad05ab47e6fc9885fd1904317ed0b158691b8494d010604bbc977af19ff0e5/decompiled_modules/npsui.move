module 0x9fad05ab47e6fc9885fd1904317ed0b158691b8494d010604bbc977af19ff0e5::npsui {
    struct NPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPSUI>(arg0, 6, b"NPSUI", b"Non Playable Sui's", b"NPC's have bridged from Sol to Sui to become $NPSUI's. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NPSUI_LOGO_591d9756d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

