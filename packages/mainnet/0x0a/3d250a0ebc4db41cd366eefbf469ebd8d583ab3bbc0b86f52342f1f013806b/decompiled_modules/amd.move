module 0xa3d250a0ebc4db41cd366eefbf469ebd8d583ab3bbc0b86f52342f1f013806b::amd {
    struct AMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMD>(arg0, 6, b"AMD", b"Artificial Moo Deng", b"A New Virtual Moo Deng Forged by AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057441_93b503d501.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

