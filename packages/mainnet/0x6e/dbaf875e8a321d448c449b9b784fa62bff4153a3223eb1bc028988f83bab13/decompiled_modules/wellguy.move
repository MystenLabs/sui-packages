module 0x6edbaf875e8a321d448c449b9b784fa62bff4153a3223eb1bc028988f83bab13::wellguy {
    struct WELLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELLGUY>(arg0, 6, b"WELLGUY", b"WELL..GUY", b"The Chillest Penguin on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WELLGUY_ICON_688f6b9b1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WELLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

