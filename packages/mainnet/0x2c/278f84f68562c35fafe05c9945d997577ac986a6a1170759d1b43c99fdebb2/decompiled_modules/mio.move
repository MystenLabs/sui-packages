module 0x2c278f84f68562c35fafe05c9945d997577ac986a6a1170759d1b43c99fdebb2::mio {
    struct MIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIO>(arg0, 6, b"MIO", b"Mio", b"I MIO YOU - On a mission give street dogs a better life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021379_c5b6222611.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

