module 0xfa3c3b0358ce9dc0d406f5001f81db45f7fd90e8a239d509ac5a430743f34b9e::bumble {
    struct BUMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBLE>(arg0, 9, b"BEE", b"bumble", b"buzzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/ba1060da-4f1d-468a-8be6-61426e95ff67.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

