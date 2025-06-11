module 0xbca9b78b103802e49fbf9679ff602fa6b0a852cd6c0e11e64cd76917f333e0cb::coinmax {
    struct COINMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINMAX>(arg0, 9, b"AN1", b"coinmax", x"6973206d6178206f6e3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9c0f7782-9384-48f4-bbac-cec163beec7e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINMAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINMAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

