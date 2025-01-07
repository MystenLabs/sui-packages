module 0xc7d1f42fdbf80384f9c6f1646b980f768caa8059cf481c889f537180067bd221::aquab {
    struct AQUAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAB>(arg0, 6, b"aquaB", b"AQUABYTE", b"Hello my name is AquaByte ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062526_58b02a8849.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

