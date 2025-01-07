module 0xd2229ebd012c4df0c4de9142dd5059420cc2d3de7105fb3f017607a33ac30b66::snsl {
    struct SNSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNSL>(arg0, 6, b"SNSL", b"SNEAKY SEAL", b"Sliding into the charts with stealth and charm. Sneaky Seal is ready to make a splash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_050629705_0dc84235cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

