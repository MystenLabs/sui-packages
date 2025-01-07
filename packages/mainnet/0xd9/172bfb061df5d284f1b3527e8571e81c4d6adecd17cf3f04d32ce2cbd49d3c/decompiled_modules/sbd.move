module 0xd9172bfb061df5d284f1b3527e8571e81c4d6adecd17cf3f04d32ce2cbd49d3c::sbd {
    struct SBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBD>(arg0, 9, b"SBD", b"Scooby doo", b"cartoon character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a482268f-e57d-4f28-96e1-0accced9798d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

