module 0x69bc5bb2c146de006ff76ac1a4a91755b5825cc85d1b1d1eca2ea25581862e19::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISM>(arg0, 6, b"TISM", b"GOT TISM ON SUI", b"Please be patient I have $TISM ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V8_s4_Lu_Z_400x400_59b3d05089.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

