module 0x37c141ad52aec435ad472f6f5b5db55540739b3ce74b7f69ae0df01e134207d9::astrai {
    struct ASTRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRAI>(arg0, 6, b"ASTRAI", b"ASTRAI SUI", b"FIRST ON SUI ASTRAI ROBOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/008582178776349_64ee0e214ddc5_4d6cbafef9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

