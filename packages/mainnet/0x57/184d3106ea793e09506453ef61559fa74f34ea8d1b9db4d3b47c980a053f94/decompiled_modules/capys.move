module 0x57184d3106ea793e09506453ef61559fa74f34ea8d1b9db4d3b47c980a053f94::capys {
    struct CAPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYS>(arg0, 6, b"CAPYS", b"SUI CAPYS", b"SUICAPYS was the first NFT project launched by SUI in 2022, and we are here to bring back the greatness of SUICAPYS $CAPYS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_21_39_54_04dd8f9c12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

