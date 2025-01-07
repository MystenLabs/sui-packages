module 0x5796d3c8427d383312746a7992ff154c1eaa918f128a01db20536bd63b12f75d::fsd {
    struct FSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSD>(arg0, 6, b"FSD", b"Four Season Dog", b"First-class lounge? Nah, Four Season Dog flies private jets only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8u_L_367_S_400x400_d82f535833.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

