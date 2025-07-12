module 0x2752f8c07646107b30e86dd58f022516385842970db6c1124e1948d9c1f65080::mkh {
    struct MKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKH>(arg0, 6, b"MKH", b"mkh.network", b"Network solutions utilizing chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_c4490c9237.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

