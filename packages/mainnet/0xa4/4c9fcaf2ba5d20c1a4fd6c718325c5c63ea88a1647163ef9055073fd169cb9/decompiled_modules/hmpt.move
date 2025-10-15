module 0xa44c9fcaf2ba5d20c1a4fd6c718325c5c63ea88a1647163ef9055073fd169cb9::hmpt {
    struct HMPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMPT>(arg0, 6, b"HMPT", b"Humpty Dumpty", b"Do the HUMPTY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760555411245.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

