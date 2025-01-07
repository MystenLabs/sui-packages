module 0xef126278fb2f1aeb40441150fcb7a7480ba4aabbae996372865bb04e6de3b608::rtd {
    struct RTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTD>(arg0, 6, b"RTD", b"Retard", b"Retard ON sUi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/60597_f0f1cc4891.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

