module 0x6dfecf47eb7714b19d83a886fd20fc25782906255fdf454749dc2adc7d778c9c::poom {
    struct POOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOM>(arg0, 6, b"POOM", b"Poom On Sui", b"Pls pls pls let me kiss u $pom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048482_a129934025.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

