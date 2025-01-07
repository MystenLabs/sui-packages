module 0x23366bc934511bfd2815c10efba55f29efcd7ce3449b4d38e00584e275d0f03d::suiale {
    struct SUIALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALE>(arg0, 6, b"SUIALE", b"SUI WHALE - $SUIALE", b"SUIALE is a legendary digital whale living on the SUI blockchain, a vast decentralized ocean of smart contracts and digital assets, as a symbol of strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Leonardo_Phoenix_2_D_art_of_a_majestic_blue_whale_with_a_gentle_0_1a6a9dd95e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

