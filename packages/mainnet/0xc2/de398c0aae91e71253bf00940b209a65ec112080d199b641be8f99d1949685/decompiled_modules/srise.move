module 0xc2de398c0aae91e71253bf00940b209a65ec112080d199b641be8f99d1949685::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE", b"We rally the masses, pushing Sui to the forefront of innovation and transformation. This isnt just about contentits about creating a culture, a voice that shapes the future of blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logocircle_ee91767ebc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

