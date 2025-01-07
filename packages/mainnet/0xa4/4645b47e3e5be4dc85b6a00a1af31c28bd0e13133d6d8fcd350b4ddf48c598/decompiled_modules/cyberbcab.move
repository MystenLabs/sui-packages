module 0xa44645b47e3e5be4dc85b6a00a1af31c28bd0e13133d6d8fcd350b4ddf48c598::cyberbcab {
    struct CYBERBCAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERBCAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERBCAB>(arg0, 6, b"Cyberbcab", b"Robotaxi Cyberbcab", b"Tesla Robotaxi Cyberbcab on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0823_2a6e9c3399.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERBCAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERBCAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

