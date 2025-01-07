module 0xd21c711c768e92b056feb255d0851d87756e0c20c7599e03f46310b0ee28bf89::cousuin {
    struct COUSUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUSUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUSUIN>(arg0, 6, b"COUSUIN", b"RETARDIO COUSUIN", b"HIGHER COUSUIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0966_1e5d0c2b1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUSUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUSUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

