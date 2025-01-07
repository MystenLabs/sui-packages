module 0x4a71d884f33d7369b97f8f1db2d11d648d375417376af0b831874a3ead723508::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 6, b"Win", b"Fight", b"President-elect", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_8bd819cf99.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

