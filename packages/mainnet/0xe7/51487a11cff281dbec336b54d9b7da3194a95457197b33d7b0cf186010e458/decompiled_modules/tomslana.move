module 0xe751487a11cff281dbec336b54d9b7da3194a95457197b33d7b0cf186010e458::tomslana {
    struct TOMSLANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMSLANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMSLANA>(arg0, 6, b"TOMSLANA", b"TOM", b"A classic story of 83 years, Tom and Jerry has accompanied our childhood. You are not just holding a token, but a whole childhood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008935_5b0b1429c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMSLANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMSLANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

