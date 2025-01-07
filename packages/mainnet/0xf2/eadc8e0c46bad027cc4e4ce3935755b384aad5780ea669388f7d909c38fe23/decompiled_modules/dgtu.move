module 0xf2eadc8e0c46bad027cc4e4ce3935755b384aad5780ea669388f7d909c38fe23::dgtu {
    struct DGTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGTU>(arg0, 6, b"DGTU", b"Dogtongue", b"OFFICIAL DOGTONGUE ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000648_e35e060060.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

