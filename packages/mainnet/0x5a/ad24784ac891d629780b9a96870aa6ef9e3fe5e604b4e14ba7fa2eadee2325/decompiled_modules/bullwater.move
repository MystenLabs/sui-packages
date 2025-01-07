module 0x5aad24784ac891d629780b9a96870aa6ef9e3fe5e604b4e14ba7fa2eadee2325::bullwater {
    struct BULLWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLWATER>(arg0, 6, b"BULLWATER", b"Bull in water", b"Jump in, hold on tight, and lets make some waves together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_192446_5a7258d19f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

