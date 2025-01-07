module 0x43d6945ed9183875bc5497c76a5f93911439a84131d1a72b141b7e996fcb326b::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 6, b"Dick", b"Dick token", b"So hot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070092_779d88ad20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

