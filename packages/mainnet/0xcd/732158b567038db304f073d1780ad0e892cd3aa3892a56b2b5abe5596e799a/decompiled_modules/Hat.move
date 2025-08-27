module 0xcd732158b567038db304f073d1780ad0e892cd3aa3892a56b2b5abe5596e799a::Hat {
    struct HAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAT>(arg0, 9, b"HAT", b"Hat", b"titan hats only. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gd1cv8AWQAA4Pw3?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

