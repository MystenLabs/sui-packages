module 0xe2c156c33b4d342df9d5f04c6e87c44b0de375cf4b08b2dcae7e5b2c71774a81::trm {
    struct TRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRM>(arg0, 6, b"TRM", b"TRUMP", b"ELON MASK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_1_cd204922ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

