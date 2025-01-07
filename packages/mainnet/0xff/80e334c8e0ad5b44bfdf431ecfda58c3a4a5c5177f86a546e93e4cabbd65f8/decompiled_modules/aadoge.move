module 0xff80e334c8e0ad5b44bfdf431ecfda58c3a4a5c5177f86a546e93e4cabbd65f8::aadoge {
    struct AADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AADOGE>(arg0, 6, b"Aadoge", b"Aaadoge", b"https://dogecoin.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016665_8afa6defe4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AADOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

