module 0x8f4870da72156e60c2e358898413d458f21fdd2cd79dee79a054183edaf77649::coin1 {
    struct COIN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN1>(arg0, 9, b"coinone", b"coin1", b"just a random coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/f0bddb65-0020-4160-9de7-ad54bfce71fe.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

