module 0x901e8df5f734215418ea018613be0780d713ddfdbdc93d034967fd751bb4a39::Wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 9, b"Water", b"Wet", b"wet af ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4052772e-71a6-45bb-9c7d-1f0db94a93d1.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

