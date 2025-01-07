module 0xa50b22643479c9bed3b0409e781dd9ac79deaf0f489c2dfa95a0a505c14e5710::wh {
    struct WH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WH>(arg0, 6, b"WH", b"Water Hagrid", b"just Hagrid. just Water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/water_hagrid_12dd393c2f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WH>>(v1);
    }

    // decompiled from Move bytecode v6
}

