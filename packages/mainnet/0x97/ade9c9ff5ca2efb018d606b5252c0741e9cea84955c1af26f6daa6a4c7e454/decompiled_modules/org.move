module 0x97ade9c9ff5ca2efb018d606b5252c0741e9cea84955c1af26f6daa6a4c7e454::org {
    struct ORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORG>(arg0, 6, b"ORG", b"ORGI", b"LETS GO MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_f7b43615bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

