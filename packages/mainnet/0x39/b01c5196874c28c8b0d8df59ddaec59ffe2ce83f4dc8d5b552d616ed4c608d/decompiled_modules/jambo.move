module 0x39b01c5196874c28c8b0d8df59ddaec59ffe2ce83f4dc8d5b552d616ed4c608d::jambo {
    struct JAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMBO>(arg0, 6, b"JAMBO", b"Jambo Sui", b"Jambo On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000381_59aeaddb82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

