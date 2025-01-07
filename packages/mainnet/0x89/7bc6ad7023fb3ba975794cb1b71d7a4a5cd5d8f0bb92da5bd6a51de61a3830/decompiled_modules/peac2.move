module 0x897bc6ad7023fb3ba975794cb1b71d7a4a5cd5d8f0bb92da5bd6a51de61a3830::peac2 {
    struct PEAC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAC2>(arg0, 6, b"Peac2", b"Peace", b"f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732617004918.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEAC2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAC2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

