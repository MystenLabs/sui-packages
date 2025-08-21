module 0xd8d55d7f0a771b5dbe39c259487d0aedb968a5b2793c1e1f65506d9d25ae7561::PHOENIX {
    struct PHOENIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHOENIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHOENIX>(arg0, 6, b"Pheonix Fire", b"PHOENIX", b"Rise from the ashes with $PHOENIX! This meme coin symbolizes rebirth, resilience, and fiery gains. Whether you're a crypto phoenix or just here for the flames, $PHOENIX will light up your portfolio. Burn the doubters, soar to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeihjza6sad7v6l4vumts35hmhidqnguxkwy46aa2ntuihhd57smu4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHOENIX>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHOENIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

