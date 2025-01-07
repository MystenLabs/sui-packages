module 0xaf33e67ae9b71f566b96c6a52290f375984ff41830655f28a497a10fedb66bd9::rtt {
    struct RTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTT>(arg0, 6, b"RTT", b"Retardino Test", b"This is just a retarded test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/retardo_49b6100311.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

