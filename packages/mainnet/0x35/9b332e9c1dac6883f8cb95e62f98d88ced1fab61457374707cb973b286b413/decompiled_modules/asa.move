module 0x359b332e9c1dac6883f8cb95e62f98d88ced1fab61457374707cb973b286b413::asa {
    struct ASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASA>(arg0, 6, b"Asa", b"asd", b"sdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/256x256_a40119c1c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

