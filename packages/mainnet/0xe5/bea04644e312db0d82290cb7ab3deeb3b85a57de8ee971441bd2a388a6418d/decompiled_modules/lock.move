module 0xe5bea04644e312db0d82290cb7ab3deeb3b85a57de8ee971441bd2a388a6418d::lock {
    struct LOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCK>(arg0, 6, b"LOCK", b"LOCK THE KEY", b"you want lock your key? come join us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/671fe69eb8e156fab0436d4a75fcc0a5_72c69ee6e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

