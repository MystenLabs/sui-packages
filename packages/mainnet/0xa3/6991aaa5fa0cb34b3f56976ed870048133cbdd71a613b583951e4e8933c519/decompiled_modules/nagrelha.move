module 0xa36991aaa5fa0cb34b3f56976ed870048133cbdd71a613b583951e4e8933c519::nagrelha {
    struct NAGRELHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAGRELHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGRELHA>(arg0, 6, b"NAGRELHA", b"Nagrelha", b"Most famous Kuduro singer from Angola!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nagrelha_590634c1f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGRELHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAGRELHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

