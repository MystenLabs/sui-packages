module 0x2c273205ec8bac30821076a5f2a46558789aec6478fb998331b239baf70fa51::harambe {
    struct HARAMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARAMBE>(arg0, 6, b"Harambe", b"Sui harambe", b"Dicks out for Harambe, the angelic ape who died so we could thrive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_19_9d334e96e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARAMBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

