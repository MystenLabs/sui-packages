module 0x7f8f266533867251e29069d0e70ad0fa7dcc8e0cc4141307c13b5de0cfc8bb22::doil {
    struct DOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOIL>(arg0, 6, b"DOIL", b"Diddy Oil", b"Oil for your D, straight from the Diddy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imresizer_1727327163749_9eee0a544b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

