module 0x2c61f36969b9e5e57e6769bb19af094499fbcd0bb8d8f7c9a897068887db3439::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"Poring", b"PoringSui", b"$PORING - The first memcoin on $SUI blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poring_7dafa91800.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORING>>(v1);
    }

    // decompiled from Move bytecode v6
}

