module 0xf8424281bae579fb6706905f12aa1d1d140fc3fb4d605bf8ef305df5eaa9082c::wrm {
    struct WRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRM>(arg0, 6, b"WRM", b"WORM", b"Worm is a unique cryptocurrency inspired by the resilient nature of worms. Built for growth and adaptability, it wriggles through the crypto space, seeking new highs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_06_13_04_39_1295a36b30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

