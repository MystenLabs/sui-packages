module 0x3712487f716713494280e034a509dab19ba36bc564a844cadeeff4a519583a0a::hopf {
    struct HOPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPF>(arg0, 6, b"HopF", b"Hop.Fuck", b"Fuck Hop.Fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9254_4bafbd66cf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

