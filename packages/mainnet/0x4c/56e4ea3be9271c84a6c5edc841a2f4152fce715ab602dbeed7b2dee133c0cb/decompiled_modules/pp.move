module 0x4c56e4ea3be9271c84a6c5edc841a2f4152fce715ab602dbeed7b2dee133c0cb::pp {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 6, b"PP", b"Pump", b"Pump it !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pump_It_Up_The_Inflatable_Party_Zone_Logo_29_806e30c3d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP>>(v1);
    }

    // decompiled from Move bytecode v6
}

