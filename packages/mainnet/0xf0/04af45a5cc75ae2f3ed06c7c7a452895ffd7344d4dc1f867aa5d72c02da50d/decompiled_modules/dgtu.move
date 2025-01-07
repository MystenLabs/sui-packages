module 0xf004af45a5cc75ae2f3ed06c7c7a452895ffd7344d4dc1f867aa5d72c02da50d::dgtu {
    struct DGTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGTU>(arg0, 6, b"DGTU", b"Dogtongue Sui", b"DOGTONGUE now it's in sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000507_7c7baa0bde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

