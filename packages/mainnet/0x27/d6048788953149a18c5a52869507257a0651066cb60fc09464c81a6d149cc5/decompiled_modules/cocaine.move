module 0x27d6048788953149a18c5a52869507257a0651066cb60fc09464c81a6d149cc5::cocaine {
    struct COCAINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCAINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCAINE>(arg0, 6, b"COCAINE", b"98% pure Ecuadorian cocaine", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.rollingstone.com/wp-content/uploads/2018/06/rs-181004-468725721.jpg?w=1581&h=1054&crop=1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COCAINE>(&mut v2, 12986452513000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCAINE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCAINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

