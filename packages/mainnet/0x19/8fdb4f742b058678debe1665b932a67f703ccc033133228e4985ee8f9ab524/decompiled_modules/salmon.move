module 0x198fdb4f742b058678debe1665b932a67f703ccc033133228e4985ee8f9ab524::salmon {
    struct SALMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMON>(arg0, 6, b"SALMON", b"Silly Salmon", x"5468652073706c61736869657374206d656d6520746f6b656e206f6e2074686520535549206e6574776f726b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039288_db08efd704.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

