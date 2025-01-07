module 0x7955047683d856934d80ec35f5e79713fcd6acd6785bfc138791441563ee7905::squide {
    struct SQUIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDE>(arg0, 6, b"SQUIDE", b"Squide", b"The Pearl of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_movepump_ca97a235ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

