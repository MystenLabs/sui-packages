module 0x40c507e066a95b709dc94df68e762b24894bbe0fa61e74b08c56c16fa24a9a81::mustard {
    struct MUSTARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTARD>(arg0, 6, b"MUSTARD", b"Mustaaaard On Sui", b"Mustaaaard on suiii!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043338_a19e46f278.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSTARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

