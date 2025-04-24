module 0x6e459e61554ceca6ba14c6ed1fb5d4e4c089fe1c125b4676fa95ea0b28be006d::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 9, b"ASD", b"dasf", b"fasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

