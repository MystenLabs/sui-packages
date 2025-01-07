module 0xc506c5d250f7d322a24690349aea081c13dff9de599d2d149464d026f34871c6::catan {
    struct CATAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAN>(arg0, 6, b"CATAN", b"Catan", b"When cats meet the devil.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catan_70a637b567.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

