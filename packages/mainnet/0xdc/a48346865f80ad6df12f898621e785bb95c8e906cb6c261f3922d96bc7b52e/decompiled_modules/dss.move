module 0xdca48346865f80ad6df12f898621e785bb95c8e906cb6c261f3922d96bc7b52e::dss {
    struct DSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSS>(arg0, 6, b"DSS", b"DarkSeraph on sui", b"Welcome warriors who have joined DarkSeraph! Let's explore the mysteries of this world together and become the greatest explorers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_24_20_15_38_5d9bd2002e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

