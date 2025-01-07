module 0x7d745bea60e51fb49138ec2d8d2fcec9f899c12560d1f4ed7b9d2fcd32d3dadf::dont {
    struct DONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONT>(arg0, 6, b"Dont", b"Dont Buy in", b"please dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/turbos_0593108216.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONT>>(v1);
    }

    // decompiled from Move bytecode v6
}

