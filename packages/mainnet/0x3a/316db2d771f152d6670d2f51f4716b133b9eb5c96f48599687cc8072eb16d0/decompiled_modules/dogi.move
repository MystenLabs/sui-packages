module 0x3a316db2d771f152d6670d2f51f4716b133b9eb5c96f48599687cc8072eb16d0::dogi {
    struct DOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGI>(arg0, 6, b"Dogi", b"Dog inu", b"Dog in sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000149669_ce8f4f054f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

