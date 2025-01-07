module 0x7d1a651d3518ab6d22f09690b19ffbe5fbc6f6b45e393f333af3d16c29bd2957::pow1gnghn {
    struct POW1GNGHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POW1GNGHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POW1GNGHN>(arg0, 6, b"Pow1gnghn", b"POW", b"dfgdfghgnghn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_plata_500_300x300_9c5ea73c31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POW1GNGHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POW1GNGHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

